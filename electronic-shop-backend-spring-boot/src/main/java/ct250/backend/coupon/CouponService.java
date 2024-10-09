package ct250.backend.coupon;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CouponService {

    @Autowired
    private CouponRepository couponRepository;

    public ArrayList<Coupon> findAll() {
        return (ArrayList<Coupon>) couponRepository.findAll();
    }

    @SuppressWarnings("null")
    public Coupon findById(Long id) {
        return couponRepository.findById(id).orElse(null);
    }

    public void add(Coupon coupon) {
        if (this.findById(coupon.getId()) == null) {
            this.couponRepository.save(coupon);
        }
    }

    @SuppressWarnings("null")
    public void deleteById(Long id) {
        this.couponRepository.deleteById(id);
    }
}
