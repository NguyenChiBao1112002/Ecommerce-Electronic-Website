<template>
    <!-- <link href=”https://unpkg.com/tailwindcss@^1.0/dist/tailwind.min.css” rel=”stylesheet”> -->
    <link href="https://unpkg.com/tailwindcss@^1.0/dist/tailwind.min.css" rel="stylesheet">
    <footer
        class="dark dark:bg-neutral-950 bg-neutral-100 text-center text-neutral-600 dark:bg-neutral-600 dark:text-neutral-200 lg:text-left font-pangea">
        <div
            class="flex items-center justify-center border-b-2 mx-6  border-neutral-900 p-6 dark:border-neutral-500 lg:justify-between">
            <div class="lg:w-[50%] mr-60 text-left">
                <h4 class="font-semibold text-white text-2xl leading-6 mb-2 flex justify-start">
                    B&B luôn lắng nghe bạn!
                </h4>
                <p class="site-footer__description" style="margin-bottom: 30px;">
                    Chúng tôi luôn trân trọng và mong đợi nhận được mọi ý kiến đóng góp từ
                    khách hàng để có thể nâng cấp trải nghiệm dịch vụ và sản phẩm tốt hơn nữa.
                </p>
                <a href="https://form.typeform.com/to/lU2oprGc?typeform-medium=embed-snippet" target="_blank"
                    class="inline-flex items-center h-12 bg-blue-500 rounded-2xl px-6 text-white font-semibold text-base tracking-wide mb-6 no-underline focus:outline-none focus:shadow-outline-blue active:bg-blue-800 transition duration-150 ease-in-out button-contribute">
                    Đóng góp ý kiến
                </a>
            </div>

            <!-- Social network icons container -->
            <div class="flex justify-center space-x-4 md:space-x-8">
                <a href="https://www.facebook.com/coolmate.me" target="_blank" class="footer-social__item"><img
                        src="https://mcdn.coolmate.me/image/June2023/mceclip1_43.png" class="w-12 h-12"
                        alt="Footer Icon facebook"></a>

                <a href="https://zalo.me/1517736583279228381" target="_blank" class="footer-social__item"><img
                        src="https://mcdn.coolmate.me/image/June2023/mceclip2_68.png" class="w-12 h-12"
                        alt="Footer Icon Zalo"></a>

                <a href="https://www.tiktok.com/@cool.coolmate" target="_blank" class="footer-social__item">
                    <img src="https://mcdn.coolmate.me/image/June2023/mceclip0_62.png" alt="Footer Icon tiktok"
                        class="w-12 h-12">
                </a>

                <a href="https://www.instagram.com/coolmate.me/" target="_blank" class="footer-social__item">
                    <img src="https://www.coolmate.me/images/footer/icon-instar.svg" alt="Footer Icon instar"
                        class="w-12 h-12">
                </a>

                <a href="https://www.youtube.com/channel/UCWw8wLlodKBtEvVt1tTAsMA" target="_blank"
                    class="footer-social__item">
                    <img src="https://www.coolmate.me/images/footer/icon-youtube.svg" alt="Footer Icon youtube"
                        class="w-12 h-12">
                </a>
            </div>
        </div>

        <div class="mx-6 py-10 text-center md:text-left">
            <div class="grid-1 grid gap-8 md:grid-cols-2 lg:grid-cols-4">
                <!-- about B&T elements section -->
                <div class="">
                    <h6 class="mb-4 flex justify-center font-semibold uppercase md:justify-start text-white">
                        VỀ B&B
                    </h6>
                    <p class="mb-4 flex items-center justify-center md:justify-start">
                        <a href="#!" class="text-neutral-600 justify-center dark:text-neutral-200 ">Câu
                            chuyện về B&B</a>
                    </p>
                    <p class="mb-4 flex items-center justify-center md:justify-start">
                        <a href="#!" class="text-neutral-600 dark:text-neutral-200">Nhà máy</a>
                    </p>
                    <p class="mb-4 flex items-center justify-center md:justify-start">
                        <a href="#!" class="text-neutral-600 dark:text-neutral-200">Care&share</a>
                    </p>
                    <p class="mb-4 flex items-center justify-center md:justify-start">
                        <a href="#!" class="text-neutral-600 dark:text-neutral-200">Đăng ký thành viên</a>
                    </p>

                </div>
                <!-- CHINH SACH section -->
                <div class="">
                    <h6 class="mb-4 flex justify-center font-semibold uppercase md:justify-start text-white">
                        CHÍNH SÁCH
                    </h6>
                    <p class="mb-4 flex items-center justify-center md:justify-start">
                        <a href="#!" class="text-neutral-600 dark:text-neutral-200">Chính sách đổi trả 60 ngày</a>
                    </p>
                    <p class="mb-4 flex items-center justify-center md:justify-start">
                        <a href="#!" class="text-neutral-600 dark:text-neutral-200">Chính sách khuyến mãi</a>
                    </p>
                    <p class="mb-4 flex items-center justify-center md:justify-start">
                        <a href="#!" class="text-neutral-600 dark:text-neutral-200">Chính sách bảo mật</a>
                    </p>
                    <p class="mb-4 flex items-center justify-center md:justify-start">
                        <a href="#!" class="text-neutral-600 dark:text-neutral-200">Chính sách giao hàng</a>
                    </p>
                </div>

                <!-- CHAM SOC KHACH HANG section -->
                <div class="">
                    <h6 class="mb-4 flex justify-center font-semibold uppercase md:justify-start text-white">
                        CHĂM SÓC KHÁCH HÀNG
                    </h6>
                    <p class="mb-4 flex items-center justify-center md:justify-start">
                        <a href="#!" class="text-neutral-600 dark:text-neutral-200">Trải nghiệm mua sắm 100% hài
                            lòng</a>
                    </p>
                    <p class="mb-4 flex items-center justify-center md:justify-start">
                        <a href="#!" class="text-neutral-600 dark:text-neutral-200">Hỏi đáp-FAQs</a>
                    </p>
                    <p class="mb-4 flex items-center justify-center md:justify-start">
                        <a href="#!" class="text-neutral-600 dark:text-neutral-200">Blog</a>
                    </p>
                    <p class="mb-4 flex items-center justify-center md:justify-start">
                        <a href="#!" class="text-neutral-600 dark:text-neutral-200">Hướng dẫn lựa chọn</a>
                    </p>
                </div>

                <!-- Contact section -->
                <div>
                    <h6 class="mb-4 flex justify-center font-semibold uppercase md:justify-start text-white">
                        LIÊN LẠC
                    </h6>
                    <p class="mb-4 flex items-center justify-center md:justify-start">
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor"
                            class="mr-3 h-5 w-5">
                            <path
                                d="M11.47 3.84a.75.75 0 011.06 0l8.69 8.69a.75.75 0 101.06-1.06l-8.689-8.69a2.25 2.25 0 00-3.182 0l-8.69 8.69a.75.75 0 001.061 1.06l8.69-8.69z" />
                            <path
                                d="M12 5.432l8.159 8.159c.03.03.06.058.091.086v6.198c0 1.035-.84 1.875-1.875 1.875H15a.75.75 0 01-.75-.75v-4.5a.75.75 0 00-.75-.75h-3a.75.75 0 00-.75.75V21a.75.75 0 01-.75.75H5.625a1.875 1.875 0 01-1.875-1.875v-6.198a2.29 2.29 0 00.091-.086L12 5.43z" />
                        </svg>
                        Ninh Kieu, Can Tho, Viet Nam
                    </p>
                    <p class="mb-4 flex items-center justify-center md:justify-start">
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor"
                            class="mr-3 h-5 w-5">
                            <path
                                d="M1.5 8.67v8.58a3 3 0 003 3h15a3 3 0 003-3V8.67l-8.928 5.493a3 3 0 01-3.144 0L1.5 8.67z" />
                            <path
                                d="M22.5 6.908V6.75a3 3 0 00-3-3h-15a3 3 0 00-3 3v.158l9.714 5.978a1.5 1.5 0 001.572 0L22.5 6.908z" />
                        </svg>
                        B&B@gmail.com
                    </p>
                    <p class="mb-4 flex items-center justify-center md:justify-start">
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor"
                            class="mr-3 h-5 w-5">
                            <path fill-rule="evenodd"
                                d="M1.5 4.5a3 3 0 013-3h1.372c.86 0 1.61.586 1.819 1.42l1.105 4.423a1.875 1.875 0 01-.694 1.955l-1.293.97c-.135.101-.164.249-.126.352a11.285 11.285 0 006.697 6.697c.103.038.25.009.352-.126l.97-1.293a1.875 1.875 0 011.955-.694l4.423 1.105c.834.209 1.42.959 1.42 1.82V19.5a3 3 0 01-3 3h-2.25C8.552 22.5 1.5 15.448 1.5 6.75V4.5z"
                                clip-rule="evenodd" />
                        </svg>
                        0862 818 458
                    </p>
                    <p class="flex items-center justify-center md:justify-start">
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor"
                            class="mr-3 h-5 w-5">
                            <path fill-rule="evenodd"
                                d="M7.875 1.5C6.839 1.5 6 2.34 6 3.375v2.99c-.426.053-.851.11-1.274.174-1.454.218-2.476 1.483-2.476 2.917v6.294a3 3 0 003 3h.27l-.155 1.705A1.875 1.875 0 007.232 22.5h9.536a1.875 1.875 0 001.867-2.045l-.155-1.705h.27a3 3 0 003-3V9.456c0-1.434-1.022-2.7-2.476-2.917A48.716 48.716 0 0018 6.366V3.375c0-1.036-.84-1.875-1.875-1.875h-8.25zM16.5 6.205v-2.83A.375.375 0 0016.125 3h-8.25a.375.375 0 00-.375.375v2.83a49.353 49.353 0 019 0zm-.217 8.265c.178.018.317.16.333.337l.526 5.784a.375.375 0 01-.374.409H7.232a.375.375 0 01-.374-.409l.526-5.784a.373.373 0 01.333-.337 41.741 41.741 0 018.566 0zm.967-3.97a.75.75 0 01.75-.75h.008a.75.75 0 01.75.75v.008a.75.75 0 01-.75.75H18a.75.75 0 01-.75-.75V10.5zM15 9.75a.75.75 0 00-.75.75v.008c0 .414.336.75.75.75h.008a.75.75 0 00.75-.75V10.5a.75.75 0 00-.75-.75H15z"
                                clip-rule="evenodd" />
                        </svg>
                        0392 357 894
                    </p>
                </div>
            </div>
        </div>

        <!--Copyright section-->
        <div
            class="dark:bg-neutral-950 bg-neutral-200 p-6 dark:bg-neutral-700 border-t-2 border-neutral-800 mx-6 text-left">
            <div class="items-start text-xs">© 2023 Copyright: CÔNG TY TNHH B&B</div>
            <div class="items-start text-xs">Mã số doanh nghiệp: 1234567895. Giấy chứng nhận đăng ký doanh nghiệp do Sở
                Kế
                hoạch và Đầu tư TP Cần Thơ cấp lần đầu ngày 20/02/2019.</div>
        </div>
    </footer>
</template>

<style scoped>
.font-pangea {
    font-family: 'Pangea', sans-serif;
}

.footer-social__item:hover {
    filter: brightness(1.5);
    /* Tăng độ sáng */
}

.site-footer__description a:hover,
.inline-flex a:hover {
    color: #f6e05e;
    /* Màu vàng */
}

.mb-4 a:hover {
    color: #f6e05e;
}

.button-contribute:hover {
    background-color: #fff;
    color: #000 !important;
    border: 1px solid #000;
}
</style>