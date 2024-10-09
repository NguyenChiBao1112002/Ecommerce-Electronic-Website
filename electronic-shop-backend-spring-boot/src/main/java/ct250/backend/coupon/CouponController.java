package ct250.backend.coupon;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;

@RestController
@RequestMapping("/coupons")
public class CouponController {

    @Autowired
    CouponService couponService;

    @GetMapping
    public ArrayList<Coupon> getAllCoupons() {
        return this.couponService.findAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getCouponById(@PathVariable Long id) {
        Coupon coupon = couponService.findById(id);
        if (coupon == null) {
            return new ResponseEntity<>("This coupon is not exist", HttpStatus.NOT_FOUND);
        }
        return new ResponseEntity<>(coupon, HttpStatus.FOUND);
    }

    @PostMapping
    public ResponseEntity<?> addCoupon(@RequestBody Coupon coupon) {
        // Check if customer existed or not?
        Coupon isExistedCoupon = couponService.findById(coupon.getId());
        if (isExistedCoupon == null) {
            this.couponService.add(coupon);
            return new ResponseEntity<>(coupon, HttpStatus.CREATED);
        }
        return new ResponseEntity<>("The coupon with id=" + coupon.getId() + " existed. Try again!", HttpStatus.BAD_REQUEST);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<String> deleteCouponById(@PathVariable Long id) {
        Coupon coupon = couponService.findById(id);
        if (coupon == null) {
            return new ResponseEntity<>("This coupon is not exist", HttpStatus.NOT_FOUND);
        }
        this.couponService.deleteById(id);
        return new ResponseEntity<>("A coupon with id=" + id + " is deleted successfully", HttpStatus.OK);
    }
}
