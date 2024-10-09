
export const ORDER_STATUS = new Map([
    ['CREATING', 'Đang tạo đơn hàng'],
    ['PENDING_PAYMENT', 'Đang thanh toán'],
    ['ON_HOLD', 'Đang chờ xử lý'],
    ['PROCESSING', 'Đang xử lý'],
    ['SHIPPED', 'Đang giao hàng'],
    ['DELIVERED', 'Giao hàng thành công'],
    ['CANCELLED', 'Đã hủy'],
    ['REFUNDED', 'Đã hoàn tiên'],
  ]);

export const ORDER_STATUS_COLOR = new Map([
    ['CREATING', '#488EF0'],
    ['PENDING_PAYMENT', '#F0C54A'],
    ['ON_HOLD', '#59E09D'],
    ['PROCESSING', '#59E09D'],
    ['SHIPPING', '#59E09D'],
    ['DELIVERED', '#59E09D'],
    ['CANCELLED', '#FF6157'],
    ['REFUNDED', '#E0D07C'],
  ]);