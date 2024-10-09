package ct250.backend.shipment;

import java.util.ArrayList;
import org.springframework.beans.factory.annotation.Autowired;
import jakarta.transaction.Transactional;
import org.springframework.stereotype.Service;

@Service
public class ShipmentService {

    @Autowired
    private ShipmentRepository shipmentRepository;

    public ArrayList<Shipment> findAllShipments() {
        return (ArrayList<Shipment>) this.shipmentRepository.findAll();
    }

    @SuppressWarnings("null")
    public Shipment findShipmentById(Long id) {
        return this.shipmentRepository.findById(id).orElse(null);
    }

    @SuppressWarnings("null")
    @Transactional
    public Shipment addShipment(Shipment shipment) {
        return this.shipmentRepository.save(shipment);
    }

    @Transactional
    public Shipment updateShipment(Long id, Shipment shipment) {
        Shipment existingShipment = findShipmentById(id);
        if (existingShipment != null) {
            // Update fields based on your requirements
            // existingShipment.setShipDate(shipment.getShipDate());
            existingShipment.setStatus(shipment.getStatus());
            existingShipment.setMethod(shipment.getMethod());

            this.shipmentRepository.save(existingShipment);
            return existingShipment;
        }
        return null;
    }

    @Transactional
    public boolean deleteShipment(Long id) {
        Shipment resultFindShipment = findShipmentById(id);
        if (resultFindShipment != null) {
            this.shipmentRepository.delete(resultFindShipment);
            return true;
        } else {
            return false;
        }
    }
}
