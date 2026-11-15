package laptopshop;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.ResultActions;
import org.springframework.transaction.annotation.Transactional;

import jakarta.persistence.EntityManager;
import laptopshop.domain.Order;
import laptopshop.domain.OrderDetail;
import laptopshop.domain.Product;
import laptopshop.domain.Review;
import laptopshop.domain.User;

@SpringBootTest(properties = {
		"spring.datasource.url=jdbc:h2:mem:laptopshop",
		"spring.datasource.driver-class-name=org.h2.Driver",
		"spring.datasource.username=sa",
		"spring.datasource.password=",
		"spring.jpa.hibernate.ddl-auto=create-drop"
})
@AutoConfigureMockMvc(addFilters = false)
@Transactional
class LaptopshopApplicationTests {

	@Autowired
	MockMvc mvc;

	@Autowired
	EntityManager entities;

	@Test
	void onlyCompletedOrdersForTheSameBuyerAndProductAllowReviews() throws Exception {
		User buyer = user("buyer@example.com");
		User otherBuyer = user("other@example.com");
		Product product = product("Laptop");
		Product otherProduct = product("Other laptop");
		order(otherBuyer, product, "COMPLETE");
		order(buyer, otherProduct, "COMPLETE");

		checkReview(buyer, product)
				.andExpect(jsonPath("$.hasReviewed").value(false))
				.andExpect(jsonPath("$.canReview").value(false));
		createReview(buyer, product).andExpect(status().isForbidden());

		Order purchase = order(buyer, product, "PENDING");
		for (String state : new String[] {"PENDING", "SHIPPING", "CANCEL"}) {
			purchase.setStatus(state);
			createReview(buyer, product).andExpect(status().isForbidden());
		}

		purchase.setStatus("COMPLETE");
		checkReview(buyer, product).andExpect(jsonPath("$.canReview").value(true));
		createReview(buyer, product)
				.andExpect(status().isCreated())
				.andExpect(jsonPath("$.data.verifiedPurchase").value(true));
		checkReview(buyer, product)
				.andExpect(jsonPath("$.hasReviewed").value(true))
				.andExpect(jsonPath("$.canReview").value(false));
		createReview(buyer, product).andExpect(status().isBadRequest());
	}

	@Test
	void verificationPersistsAfterOrderChangesAndIsAbsentFromLegacyReviews() throws Exception {
		User buyer = user("buyer@example.com");
		User oldBuyer = user("old@example.com");
		Product product = product("Laptop");
		Order purchase = order(buyer, product, "COMPLETE");
		Review legacy = Review.builder().rating(4).user(oldBuyer).product(product).build();
		entities.persist(legacy);
		order(oldBuyer, product, "COMPLETE");

		createReview(buyer, product).andExpect(status().isCreated());
		purchase.setStatus("CANCEL");
		entities.flush();
		entities.clear();

		mvc.perform(get("/api/reviews/product/{id}", product.getId()))
				.andExpect(status().isOk())
				.andExpect(jsonPath("$.data[?(@.userFullName == 'buyer@example.com')].verifiedPurchase").value(true))
				.andExpect(jsonPath("$.data[?(@.userFullName == 'old@example.com')].verifiedPurchase").value(false));
	}

	private ResultActions checkReview(User user, Product product) throws Exception {
		return mvc.perform(get("/api/reviews/check")
				.param("productId", Long.toString(product.getId()))
				.sessionAttr("id", user.getId()))
				.andExpect(status().isOk());
	}

	private ResultActions createReview(User user, Product product) throws Exception {
		return mvc.perform(post("/api/reviews")
				.sessionAttr("id", user.getId())
				.contentType(MediaType.APPLICATION_JSON)
				.content("""
						{"productId": %d, "rating": 5}
						""".formatted(product.getId())));
	}

	private User user(String email) {
		User user = new User();
		user.setEmail(email);
		user.setFullName(email);
		user.setPassword("test-password");
		entities.persist(user);
		return user;
	}

	private Product product(String name) {
		Product product = new Product();
		product.setName(name);
		product.setDetailDesc("Product detail");
		product.setShortDesc("Product summary");
		product.setPrice(100);
		product.setQuantity(1);
		entities.persist(product);
		return product;
	}

	private Order order(User user, Product product, String status) {
		Order order = new Order();
		order.setUser(user);
		order.setStatus(status);
		entities.persist(order);

		OrderDetail detail = new OrderDetail();
		detail.setOrder(order);
		detail.setProduct(product);
		detail.setQuantity(1);
		entities.persist(detail);
		return order;
	}
}
