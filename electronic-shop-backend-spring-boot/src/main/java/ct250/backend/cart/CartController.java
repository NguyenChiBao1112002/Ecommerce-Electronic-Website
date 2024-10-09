package ct250.backend.cart;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/customers/{customerId}/cart")
public class CartController {

    @Autowired
    CartService cartService;

    @PostMapping
    public ResponseEntity<?> addProductDetailToCart(@PathVariable Long customerId,
             @RequestBody CartDetail cartDetail) {
        CartDetail cartDetailDB = this.cartService.addProductDetailToCart(customerId, cartDetail);
        if (cartDetailDB == null) {
            return new ResponseEntity<>("This product does not have enough quantity", HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<>(cartDetailDB, HttpStatus.CREATED);
    }

    @GetMapping
    public ResponseEntity<?> getCart(@PathVariable Long customerId) {
        ArrayList<CartDetail> cartDetails = this.cartService.getAllCartDetails(customerId);
        if (cartDetails.size() > 0) {
            return new ResponseEntity<>(cartDetails, HttpStatus.OK);
        }
        return new ResponseEntity<>("This cart is empty", HttpStatus.OK);
    }

    @GetMapping("/{cartDetailId}")
    public ResponseEntity<?> getCartDetail(@PathVariable Long cartDetailId) {
        CartDetail cartDetail = this.cartService.findCartDetailById(cartDetailId);
        if (cartDetail != null) {
            return new ResponseEntity<>(cartDetail, HttpStatus.OK);
        }
        return new ResponseEntity<>("This cart detail is not exist", HttpStatus.NOT_FOUND);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteCartDetail(@PathVariable(value = "customerId") Long customerId, @PathVariable(value = "id") Long id) {
        this.cartService.deleteCartDetail(id);
        return new ResponseEntity<>(this.cartService.getAllCartDetails(customerId), HttpStatus.OK);
    }

    @PutMapping("/{cartDetailId}")
    public ResponseEntity<?> updateCartDetail(@PathVariable Long cartDetailId,
            @RequestBody CartDetail cartDetail) {
        CartDetail updatedCartDetail = this.cartService.updateCartDetail(cartDetail);

        return new ResponseEntity<>(updatedCartDetail, HttpStatus.OK);
    }

}
