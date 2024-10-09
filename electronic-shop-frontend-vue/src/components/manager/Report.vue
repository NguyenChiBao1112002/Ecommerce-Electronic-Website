<template>
    <div class="mx-2 my-3 overflow-y-auto custom-scrollbar" style="max-height: 630px;">
        <div>
            <div class="flex flex-row">
                <div class="basis-1/4"></div>
                <div class="basis-1/2 font-sans text-2xl mb-2 text-center">BẢNG THỐNG KÊ CÁC LOẠI THIẾT BỊ</div>
                <div class="basis-1/4 flex justify-end">
                    <button @click="exportReport"
                        class="mr-3 mb-2 bg-gradient-to-b from-fuchsia-500 to-cyan-300 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">
                        Xuất báo cáo
                    </button>
                </div>
            </div>
            <div ref='tableOne'>
                <table class="w-full overflow-auto text-sm text-left rtl:text-right text-gray-500 dark:text-gray-400">
                    <thead
                        class="text-xs font-sans text-gray-700 uppercase bg-gray-200 dark:bg-gray-700 dark:text-gray-400">
                        <tr>
                            <th scope="col" class="px-5 py-3 text-center">
                                Loại
                            </th>
                            <th scope="col" class="px-5 py-3 text-center">
                                Số lượng bán
                            </th>
                            <th scope="col" class="px-5 py-3 text-center">
                                Số lượng tồn
                            </th>
                            <th scope="col" class="px-5 py-3 text-center">
                                Doanh thu (vnđ)
                            </th>
                            <th scope="col" class="px-5 py-3 text-center">
                                Lợi nhuận (vnđ)
                            </th>
                        </tr>
                    </thead>
                    <tbody class="table11">
                        <tr v-for="(groupedProductDetail, index) in groupedProductDetails" :key="index"
                            class="bg-white border-b dark:bg-gray-800 dark:border-gray-700 text-sm">
                            <td class="px-5 py-3 text-center">{{ groupedProductDetail.type }}</td>
                            <td class="px-5 py-3 text-center">{{ calculateTotalSold(groupedProductDetail.details) }}
                            </td>
                            <td class="px-5 py-3 text-center">{{
                                calculateTotaInventoryNumber(groupedProductDetail.details) }}
                            </td>
                            <td class="px-5 py-3 text-center">{{
                                formatNumberWithCommas(calculateTotaRevenue(groupedProductDetail.details)) }}
                            </td>
                            <td class="px-5 py-3 text-center">{{
                                formatNumberWithCommas(calculateTotaProfit(groupedProductDetail.details)) }}
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
        <div class="mt-5">
            <div class="flex justify-center">
                <div class="font-sans text-2xl mb-2">BẢNG THỐNG KÊ SỐ LƯỢNG THIẾT BỊ THEO NHÀ CUNG CẤP</div>
            </div>
            <div>
                <table id="table2"
                    class="w-full overflow-auto text-sm text-left rtl:text-right text-gray-500 dark:text-gray-400">
                    <thead
                        class="text-xs font-sans text-gray-700 uppercase bg-gray-200 dark:bg-gray-700 dark:text-gray-400">
                        <tr>
                            <th scope="col" class="px-5 py-3 text-center">
                                Nhà cung cấp
                            </th>
                            <th scope="col" class="px-5 py-3 text-center">
                                Số lượng
                            </th>
                            <th scope="col" class="px-5 py-3 text-center">
                                Số lượng bán
                            </th>
                            <th scope="col" class="px-5 py-3 text-center">
                                Số lượng tồn
                            </th>
                            <th scope="col" class="px-5 py-3 text-center">
                                Doanh thu (vnđ)
                            </th>
                            <th scope="col" class="px-5 py-3 text-center">
                                Lợi nhuận (vnđ)
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr v-for="(groupedProductDetailsBySupplier, index) in groupedProductDetailsBySuppliers"
                            :key="index" class="bg-white border-b dark:bg-gray-800 dark:border-gray-700 text-sm">
                            <td class="px-5 py-3 text-center">{{ groupedProductDetailsBySupplier.material }}</td>
                            <td class="px-5 py-3 text-center">{{
                                calculateTotalNumber(groupedProductDetailsBySupplier.details) }}
                            </td>
                            <td class="px-5 py-3 text-center">{{
                                calculateTotalSold(groupedProductDetailsBySupplier.details) }}
                            </td>
                            <td class="px-5 py-3 text-center">{{
                                calculateTotaInventoryNumber(groupedProductDetailsBySupplier.details) }}
                            </td>
                            <td class="px-5 py-3 text-center">{{
                                formatNumberWithCommas(calculateTotaRevenue(groupedProductDetailsBySupplier.details)) }}
                            </td>
                            <td class="px-5 py-3 text-center">{{
                                formatNumberWithCommas(calculateTotaProfit(groupedProductDetailsBySupplier.details)) }}
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</template>

<script setup lang="ts">
import { ref, onMounted, computed } from 'vue';
import axios from 'axios';
import type { ProductDetailObject, ProductObject } from '../cart/cart-item/DefaultCartItem.vue';

const products = ref<ProductObject[]>([]);
interface GroupedProductDetails {
    type: String;
    details: ProductDetailObject[];
}

interface GroupedProductDetailsBySupplier {
    material: String;
    details: ProductDetailObject[];
}
const groupedProductDetails = ref<GroupedProductDetails[]>([]);
const groupedProductDetailsBySuppliers = ref<GroupedProductDetailsBySupplier[]>([]);
const groupProductDetailsByType = (details: ProductDetailObject[]) => {
    const groupedDetailsMap = new Map<string, ProductDetailObject[]>();
    // Duyệt qua từng chi tiết sản phẩm và nhóm chúng theo loại
    details.forEach(detail => {
        const type = detail.product.type;
        if (!groupedDetailsMap.has(type.toString())) {
            // Nếu loại chưa xuất hiện, thêm loại và danh sách chi tiết sản phẩm mới
            groupedDetailsMap.set(type.toString(), [detail]);
        } else {
            // Nếu loại đã xuất hiện, thêm chi tiết sản phẩm vào danh sách tương ứng
            const existingDetails = groupedDetailsMap.get(type.toString());
            if (existingDetails) {
                existingDetails.push(detail);
            }
        }
    });
    // Chuyển đổi Map thành mảng các nhóm chi tiết sản phẩm
    const groupedDetails: GroupedProductDetails[] = [];
    groupedDetailsMap.forEach((details, type) => {
        groupedDetails.push({ type, details });
    });
    return groupedDetails;
};

const groupProductDetailsBySupplier = (details: ProductDetailObject[]) => {
    const groupedDetailsMap = new Map<string, ProductDetailObject[]>();
    details.forEach(detail => {
        const material = detail.product.material;
        if (!groupedDetailsMap.has(material.toString())) {
            groupedDetailsMap.set(material.toString(), [detail]);
        } else {
            const existingDetails = groupedDetailsMap.get(material.toString());
            if (existingDetails) {
                existingDetails.push(detail);
            }
        }
    });

    const groupedDetails: GroupedProductDetailsBySupplier[] = [];
    groupedDetailsMap.forEach((details, material) => {
        groupedDetails.push({ material, details });
    });
    return groupedDetails;
};

function formatNumberWithCommas(number) {
    return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ".");
}

const calculateTotalNumber = (details: ProductDetailObject[]) => {
    return details.reduce((total, detail) => total + detail.quantity, 0);
};

const calculateTotalSold = (details: ProductDetailObject[]) => {
    return details.reduce((total, detail) => total + detail.sold, 0);
};
const calculateTotaInventoryNumber = (details: ProductDetailObject[]) => {
    return details.reduce((total, detail) => total + detail.quantity, 0) - details.reduce((total, detail) => total + detail.sold, 0);
};

const calculateTotaRevenue = (details: ProductDetailObject[]) => {
    return details.reduce((total, detail) => total + detail.product.price, 0);
};

const calculateTotaProfit = (details: ProductDetailObject[]) => {
    return details.reduce((total, detail) => total + detail.product.price, 0) - details.reduce((total, detail) => total + detail.product.cost, 0);
};

import { jsPDF } from "jspdf";
import autoTable from 'jspdf-autotable'
const exportReport = async () => {
    const pdf = new jsPDF('p', 'pt', 'a4');
    const largeFontSize = 18;
    const largeText = 'B&B COMPANY';
    const largeTextWidth = pdf.getStringUnitWidth(largeText) * largeFontSize / pdf.internal.scaleFactor;
    const largeTextX = (pdf.internal.pageSize.width - largeTextWidth) / 2;
    const largeTextY = 85; // 5 là khoảng cách giữa các dòng
    pdf.setFont('Helvetica', 'bold');
    pdf.setFontSize(largeFontSize);
    pdf.text(largeText, largeTextX, largeTextY);
    pdf.setFont('Helvetica', 'normal');
    pdf.setFontSize(15);

    pdf.text('STATISTICAL TABLE OF DEVICE TYPES', 145, 110)

    const dataTable1: any[] = [];
    groupedProductDetails.value.forEach(groupedProductDetail => {
        const rowData = [
            groupedProductDetail.type,
            calculateTotalSold(groupedProductDetail.details),
            calculateTotaInventoryNumber(groupedProductDetail.details),
            formatNumberWithCommas(calculateTotaRevenue(groupedProductDetail.details)),
            formatNumberWithCommas(calculateTotaProfit(groupedProductDetail.details))
        ];
        dataTable1.push(rowData);
    });
    autoTable(pdf, {
        startY: 120,
        styles: {
            fontSize: 13,
            cellWidth: 'wrap',
            halign: 'center', // Căn giữa nội dung ô
        },
        columnStyles: {
            0: { cellWidth: 'auto' }
        },
        head: [['Supplier', 'Quantity Sold', 'Inventory Number', 'Revenue', 'Profit']],
        body: dataTable1,
    });


    const dataTable2: any[] = [];
    groupedProductDetailsBySuppliers.value.forEach(groupedProductDetailsBySupplier => {
        const rowData = [
            groupedProductDetailsBySupplier.material,
            calculateTotalNumber(groupedProductDetailsBySupplier.details),
            calculateTotalSold(groupedProductDetailsBySupplier.details),
            calculateTotaInventoryNumber(groupedProductDetailsBySupplier.details),
            formatNumberWithCommas(calculateTotaRevenue(groupedProductDetailsBySupplier.details)),
            formatNumberWithCommas(calculateTotaProfit(groupedProductDetailsBySupplier.details)),
        ];
        dataTable2.push(rowData);
    });
    pdf.text('STATISTICAL TABLE OF NUMBER OF DEVICES BY SUPPLIER', 85, pdf.previousAutoTable.finalY + 50)
    autoTable(pdf, {
        startY: pdf.previousAutoTable.finalY + 60,
        styles: {
            fontSize: 12,
            cellWidth: 'wrap',
            halign: 'center',
        },
        columnStyles: {
            0: { cellWidth: 'auto' }
        },
        head: [['Supplier', 'Quantity', 'Quantity Sold', 'Inventory Number', 'Revenue', 'Profit']],
        body: dataTable2,
    })
    pdf.setFontSize(14);
    pdf.text('Can Tho, ngay..., thang..., nam...', 325, pdf.previousAutoTable.finalY + 50)
    pdf.text('Nguoi thuc hien', 370, pdf.previousAutoTable.finalY + 70)
    pdf.save("report.pdf");
}

const apiUrl = 'http://localhost:8080';
onMounted(async () => {
    try {
        const response = await axios.get(`${apiUrl}/products`);
        products.value = response.data;

        // Tạo mảng promise để lưu trữ tất cả các promise lấy chi tiết sản phẩm
        const detailPromises = products.value.map(async (product) => {
            const responseProductDetail = await axios.get(`${apiUrl}/products/${product.id}/details`);
            return responseProductDetail.data;
        });

        const allDetails = await Promise.all(detailPromises);
        // Gom nhóm chi tiết sản phẩm sau khi đã lấy được tất cả dữ liệu
        const allProductDetails = allDetails.flat(); // Hợp nhất các mảng chi tiết sản phẩm thành một mảng duy nhất
        groupedProductDetails.value = groupProductDetailsByType(allProductDetails);
        groupedProductDetailsBySuppliers.value = groupProductDetailsBySupplier(allProductDetails);
        console.log(groupedProductDetails.value);
    } catch (error) {
        console.error('Lỗi khi lấy thông tin người dùng:', error);
    }
});
</script>

<style scoped>
.centered {
    display: flex;
    align-items: center;
    justify-content: center;
    height: 100%;
}

.custom-scrollbar::-webkit-scrollbar {
    width: 5px;
    height: 5px;
}

.custom-scrollbar::-webkit-scrollbar-thumb {
    background-color: rgba(0, 0, 0, 0.2);
    border-radius: 3px;
}

.custom-scrollbar::-webkit-scrollbar-track {
    background-color: rgba(0, 0, 0, 0.1);
    border-radius: 3px;
}
</style>