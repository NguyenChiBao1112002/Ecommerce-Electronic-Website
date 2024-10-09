package ct250.backend.product;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.apache.mahout.cf.taste.recommender.RecommendedItem;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ct250.backend.imagedata.ImageData;
import jakarta.transaction.Transactional;

@Service
@Transactional
public class ProductService {

    @Autowired
    private ProductRepository productRepository;

    @Autowired
    private ProductDetailRepository productDetailRepository;

    @SuppressWarnings("null")
    void addProduct(Product product) {
        this.productRepository.save(product);
    }

    ArrayList<Product> getAllProducts() {
        return (ArrayList<Product>) this.productRepository.findAll();
    }

    @SuppressWarnings("null")
    public Product findProductById(Long id) {
        return this.productRepository.findById(id).orElse(null);
    }

    public Product updateProduct(Long id, Product productUpdateInfo) {
        Product existingProduct = this.productRepository.findById(id).orElse(null);
        if (existingProduct != null) {
            existingProduct.setName(
                    productUpdateInfo.getName() != null ? productUpdateInfo.getName() : existingProduct.getName());
            existingProduct.setPrice(
                    productUpdateInfo.getPrice() != null ? productUpdateInfo.getPrice() : existingProduct.getPrice());
            existingProduct.setCost(
                    productUpdateInfo.getCost() != null ? productUpdateInfo.getCost() : existingProduct.getCost());
            existingProduct.setSalePercent(productUpdateInfo.getSalePercent() >= 0 ? productUpdateInfo.getSalePercent()
                    : existingProduct.getSalePercent());
            existingProduct.setType(
                    productUpdateInfo.getType() != null ? productUpdateInfo.getType() : existingProduct.getType());
            existingProduct.setMaterial(productUpdateInfo.getMaterial() != null ? productUpdateInfo.getMaterial()
                    : existingProduct.getMaterial());
            existingProduct.setImageData(productUpdateInfo.getImageData() != null ? productUpdateInfo.getImageData()
                    : existingProduct.getImageData());

            this.productRepository.save(existingProduct);
            return existingProduct;
        } else {
            return null;
        }
    }

    Product updateProductImages(Long id, ImageData images) {
        Product product = this.findProductById(id);
        product.setImageData(images);
        return this.productRepository.save(product);
    }

    @SuppressWarnings("null")
    void deleteProductById(Long id) {
        this.productRepository.deleteById(id);
    }

    public void addProductDetail(Long productId, ProductDetail productDetail) {
        Product product = this.findProductById(productId);

        if (product != null) {
            productDetail.setProduct(product);
            this.productDetailRepository.save(productDetail);
        }
    }

    public ProductDetail updateProductDetail(Long id, ProductDetail productDetailUpdateInfo) {
        ProductDetail existingProductDetail = this.productDetailRepository.findById(id).orElse(null);

        if (existingProductDetail != null) {
            existingProductDetail.setSize(productDetailUpdateInfo.getSize() != null ? productDetailUpdateInfo.getSize()
                    : existingProductDetail.getSize());
            existingProductDetail
                    .setColor(productDetailUpdateInfo.getColor() != null ? productDetailUpdateInfo.getColor()
                            : existingProductDetail.getColor());
            existingProductDetail.setColorImage(
                    productDetailUpdateInfo.getColorImage() != null ? productDetailUpdateInfo.getColorImage()
                            : existingProductDetail.getColorImage());
            existingProductDetail.setUnit(productDetailUpdateInfo.getUnit() != null ? productDetailUpdateInfo.getUnit()
                    : existingProductDetail.getUnit());
            existingProductDetail
                    .setQuantity(productDetailUpdateInfo.getQuantity() > 0 ? productDetailUpdateInfo.getQuantity()
                            : existingProductDetail.getQuantity());
            existingProductDetail.setSold(productDetailUpdateInfo.getSold() >= 0 ? productDetailUpdateInfo.getSold()
                    : existingProductDetail.getSold());
            existingProductDetail.setImageLinks(
                    productDetailUpdateInfo.getImageLinks() != null ? productDetailUpdateInfo.getImageLinks()
                            : existingProductDetail.getImageLinks());
            existingProductDetail.setImageLink(
                    productDetailUpdateInfo.getImageLink() != null ? productDetailUpdateInfo.getImageLink()
                            : existingProductDetail.getImageLink());

            this.productDetailRepository.save(existingProductDetail);
            return existingProductDetail;
        } else {
            return null;
        }
    }

    @SuppressWarnings("null")
    public ProductDetail updateProductDetail(ProductDetail productDetail) {
        return this.productDetailRepository.save(productDetail);
    }

    ArrayList<ProductDetail> getListProductDetails() {
        return (ArrayList<ProductDetail>) this.productDetailRepository.findAll();
    }

    ArrayList<ProductDetail> getAllProductDetails(Long productId) {
        return (ArrayList<ProductDetail>) this.productDetailRepository.findByProduct_Id(productId);
    }

    @SuppressWarnings("null")
    public ProductDetail findProductDetailById(Long id) {
        return this.productDetailRepository.findById(id).orElse(null);
    }

    public ArrayList<Product> findProductByTypes(ArrayList<ProductType> types) {
        ArrayList<Product> filteredProducts = new ArrayList<Product>();
        for (ProductType type : types) {
            filteredProducts.addAll(this.productRepository.findProductsByType(type));
        }
        return filteredProducts;
    }

    public ArrayList<ProductDetail> findProductDetailByColor(String color) {
        return (ArrayList<ProductDetail>) this.productDetailRepository.findByColor(color);
    }

    public ArrayList<ProductDetail> findProductDetailByColor(Long productId, String color) {
        Product product = this.findProductById(productId);
        return (ArrayList<ProductDetail>) this.productDetailRepository.findByColor(color);
    }

    public ArrayList<ProductDetail> findProductDetailBySize(String size) {
        return (ArrayList<ProductDetail>) this.productDetailRepository.findBySize(size);
    }

    public ArrayList<ProductDetail> findProductDetailByColorAndSize(String color, String size) {
        return (ArrayList<ProductDetail>) this.productDetailRepository.findByColorAndSize(color, size);
    }

    @SuppressWarnings("null")
    void deleteProductDetailById(Long id) {
        this.productDetailRepository.deleteById(id);
    }

    public List<Product> findProductByIds(List<RecommendedItem> recommendations) {

        List<Long> result = recommendations.stream()
                .map(recommendedItem -> recommendedItem.getItemID())
                .collect(Collectors.toList());

        return this.productRepository.findAllById(result);
    }

    public ArrayList<Product> findTop5MostSale() {
        ArrayList<Product> filteredProducts = this.getAllProducts();
        ArrayList<Product> recommendedProducts = new ArrayList<>();
        Map<Long, Integer> productSales = new HashMap<Long, Integer>();

        for (Product product : filteredProducts) {
            this.getAllProductDetails(product.getId())
                    .stream()
                    .forEach(productDetail -> productSales.put(
                            product.getId(),
                            productSales.get(product.getId()) == null ? Integer.valueOf(productDetail.getSold())
                                    : Integer.valueOf(productDetail.getSold()) + productSales.get(product.getId())));
        }
        productSales.entrySet()
                .stream()
                .sorted(Collections.reverseOrder(Map.Entry.comparingByValue()))
                .limit(5)
                .forEach(entry -> {
                    recommendedProducts.add(this.findProductById(entry.getKey()));
                });

        return recommendedProducts;
    }

    public ArrayList<Product> findTopRemainMostSale(int topRemainSale) {
        ArrayList<Product> filteredProducts = this.getAllProducts();
        ArrayList<Product> recommendedProducts = new ArrayList<>();
        Map<Long, Integer> productSales = new HashMap<Long, Integer>();

        for (Product product : filteredProducts) {
            this.getAllProductDetails(product.getId())
                    .stream()
                    .forEach(productDetail -> productSales.put(
                            product.getId(),
                            productSales.get(product.getId()) == null ? Integer.valueOf(productDetail.getSold())
                                    : Integer.valueOf(productDetail.getSold()) + productSales.get(product.getId())));
        }
        productSales.entrySet()
                .stream()
                .sorted(Collections.reverseOrder(Map.Entry.comparingByValue()))
                .limit(topRemainSale)
                .forEach(entry -> {
                    recommendedProducts.add(this.findProductById(entry.getKey()));
                });

        return recommendedProducts;
    }

    ProductDetail updateProductDetailImages(Long id, String images) {
        ProductDetail detail = this.findProductDetailById(id);
        detail.setImageLinks(images);
        return this.productDetailRepository.save(detail);
    }

}
