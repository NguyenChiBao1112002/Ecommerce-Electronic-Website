package ct250.backend.product;

import java.util.HashMap;
import java.util.Map;

public enum ProductType {
    PHONE,
    LAPTOP,
    TABLET,
    SMARTWATCH,
    SCREEN,
    HEADPHONE,
    SPEAKER,
    PRINTER,
    KEYBOARD,
    MOUSE,
    OTHER;

    private static final Map<String, ProductType> stringToEnum = new HashMap<>();

    static {
        for (ProductType productType : values()) {
            stringToEnum.put(productType.name(), productType);
        }
    }

    public static ProductType fromString(String value) {
        return stringToEnum.get(value);
    }
}
