package laptopshop.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import laptopshop.domain.Product;

@Repository
public interface ProductRepository extends JpaRepository<Product, Long>, JpaSpecificationExecutor<Product> {

    @Query("SELECT DISTINCT p.factory FROM Product p WHERE p.factory IS NOT NULL AND p.factory <> '' ORDER BY p.factory ASC")
    List<String> findDistinctFactories();

    Page<Product> findAllByFactoryIgnoreCase(String factory, Pageable page);
}
