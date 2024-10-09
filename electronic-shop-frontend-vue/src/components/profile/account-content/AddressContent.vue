<script setup lang="ts">
import { UserService, type Address, type User } from '@/services/user.service';
import { ref } from 'vue';

// const props = defineProps<{
//   order: any
// }>();

const isLoading = ref(true)

const addresses = ref<Address[]>([]);
let userService = new UserService();
let user: User;

setTimeout(async () => {

    const response = await userService.getCity();

    response.data.data.forEach(city => {
        let maxLength = 0;
        let cityWithFullTitle = '';
        city.NameExtension.forEach(province => {
            if (province.length > maxLength) {
                maxLength = province.length;
                cityWithFullTitle = province;
            }
        });
        cities.push({ name: cityWithFullTitle, id: city.ProvinceID })
    });
    cities.sort(sortByName);


    user = JSON.parse(localStorage.getItem("account")!);

    getAddressesByCustomerId();

}, 1000);


const showCityDropdown = ref(false);
const showDistrictDropdown = ref(false);
const showVillageDropdown = ref(false);

const activeCityIndex = ref<number | null>(null);
const activeDistrictIndex = ref<number | null>(null);
const activeVillageIndex = ref<number | null>(null);

const activeCity = ref<{ name: string, id: string }>({ name: "Chọn Tỉnh / Thành", id: '-1' });
const activeDistrict = ref<{ name: string, id: string }>({ name: "Chọn Quận / Huyện", id: '-1' });
const activeVillage = ref<{ name: string, id: string, code: string }>({ name: "Chọn Phường / Xã", id: '-1', code: '-1' });

const customerInfo = JSON.parse(localStorage.getItem('account')!);

var cities: { name: string, id: string }[] = [];
const districts = ref<{ name: string, id: string }[]>([]);
const villages = ref<{ name: string, id: string, code: string }[]>([]);

const setActiveCity = (index: number) => {
    activeCityIndex.value = index;
};

const setActiveDistrict = (index: number) => {
    activeDistrictIndex.value = index;
};

const setActiveVillage = (index: number) => {
    activeVillageIndex.value = index;
};

const sortByName = (a, b) => {
    if (a.name > b.name) {
        return 1;
    }

    if (a.name < b.name) {
        return -1;
    }

    return 0;
}

const toggleCityDropdown = async () => {
    showCityDropdown.value = !showCityDropdown.value;

    if (activeCityIndex.value == null && activeCity.value.name != "Chọn Tỉnh / Thành") return;

    if (!showCityDropdown.value) {
        activeCity.value = cities[activeCityIndex.value!];

        console.log(activeCity.value)

        let response = (await userService.getDistrict(activeCity.value.id)).data.data.map(
            res => { return { name: res.DistrictName, id: res.DistrictID } }
        );

        districts.value = response;
        districts.value.sort(sortByName);

    }
};

const toggleDistrictDropdown = async () => {
    if (districts.value.length === 0) return;
    showDistrictDropdown.value = !showDistrictDropdown.value;

    if (activeDistrictIndex.value == null && activeDistrict.value.name != "Chọn Quận / Huyện") return;

    if (!showDistrictDropdown.value) {
        activeDistrict.value = districts.value[activeDistrictIndex.value!];

        let response = (await userService.getWard(activeDistrict.value.id)).data.data.map(
            res => { return { name: res.WardName, id: res.WardID, code: res.WardCode } }
        );

        villages.value = response;
        villages.value.sort(sortByName);

    }
};

const toggleVillageDropdown = async () => {
    if (activeDistrictIndex.value === null) return;
    showVillageDropdown.value = !showVillageDropdown.value;

    if (activeVillageIndex.value == null && activeVillage.value.name != "Chọn Phường / Xã") return;

    if (!showVillageDropdown.value) {
        activeVillage.value = villages.value[activeVillageIndex.value!];
    }
};

const customerName = ref<string>(customerInfo.name)
const customerAddress = ref<string>("")
const customerPhone = ref<string>(customerInfo.phone)

const addNewAddress = async () => {

    isLoading.value = true;

    let data: Address = {
        belongsTo: customerName.value,
        phone: customerPhone.value,
        address: customerAddress.value,
        cityId: activeCity.value.id,
        districtId: activeDistrict.value.id,
        wardId: activeVillage.value.code,
        customer: customerInfo,
        isDefault: false,
    }

    await userService.postAddress(data);

    getAddressesByCustomerId();
}

const updateToDefaultAddress = async (address) => {

    isLoading.value = true;

    let data = address;

    data.isDefault = true;

    const response = (await userService.updateAddress(customerInfo.id, data));

    getAddressesByCustomerId();

}

const updateAddress = async () => {

    isLoading.value = true;

    updatingAddress.value.cityId = activeCity.value.id;
    updatingAddress.value.districtId = activeDistrict.value.id;
    updatingAddress.value.wardId = activeVillage.value.code;

    let data = updatingAddress.value;

    (await userService.updateAddress(customerInfo.id, data));

    getAddressesByCustomerId();

}

const updatingAddress = ref<Address>({
    id: '',
    belongsTo: '',
    phone: '',
    address: '',
    cityId: '',
    districtId: '',
    wardId: '',
    customer: customerInfo,
    isDefault: false,
    displayingAddress: '',
});

const getUpdatingAddress = async (address: Address) => {
    updatingAddress.value = address;

    let city = await userService.getCityById(address.cityId);
    let maxLength = 0;
    city.NameExtension.forEach(province => {
        if (province.length > maxLength) {
            maxLength = province.length;
            city.ProvinceName = province;
        }
    });

    let district = await userService.getDistrictById(address.cityId, address.districtId);

    let ward = await userService.getWardById(address.districtId, address.wardId);

    activeCity.value = { name: city.ProvinceName, id: address.cityId };
    activeDistrict.value = { name: district.DistrictName, id: address.districtId };
    activeVillage.value = { name: ward.WardName, id: ward.id, code: address.wardId };

    activeCityIndex.value = cities.findIndex(x => x.id == address.cityId);

    districts.value = (await userService.getDistrict(activeCity.value.id)).data.data.map(
        res => { return { name: res.DistrictName, id: res.DistrictID } }
    );

    districts.value.sort(sortByName);

    activeDistrictIndex.value = districts.value.findIndex(x => x.id == address.districtId);

    villages.value = (await userService.getWard(activeDistrict.value.id)).data.data.map(
        res => { return { name: res.WardName, id: res.WardID, code: res.WardCode } }
    );

    villages.value.sort(sortByName);

    activeVillageIndex.value = villages.value.findIndex(x => x.code == address.wardId);

}

const deleteAddress = async (address: Address) => {

    isLoading.value = true;

    await userService.deleteAddress(address.id);

    getAddressesByCustomerId();

}

const getAddressesByCustomerId = async () => {

    addresses.value = (await userService.getAddressesByCustomerId(user.id)).data;

    addresses.value.reverse().forEach(async (address, index) => {
        let city = await userService.getCityById(address.cityId)

        let district = await userService.getDistrictById(address.cityId, address.districtId)

        let ward = await userService.getWardById(address.districtId, address.wardId)

        address.displayingAddress = address.address + ', ' + ward.WardName + ', ' + district.DistrictName + ', ' + city.ProvinceName;

        if (address.isDefault) {
            addresses.value.splice(index, 1);
            addresses.value.unshift(address);
        }
    })

    setTimeout(() => {
        isLoading.value = false;
    }, 500);
}

</script>

<template>
    <div class="loader-container" v-if="isLoading"><span class="loader"></span></div>
    <div class="account-content my-50">
        <div class="account-address">
            <h2 class="account-page-title">
                Địa chỉ của tôi
            </h2>
            <button class="account-page-button" data-bs-toggle="modal" :data-bs-target="`#address-modal`" @click="">
                Thêm địa chỉ mới
            </button>
        </div>
        <div class="account-address-title">Sổ địa chỉ</div>
        <div class="account-address-content fst-italic text-secondary" v-if="addresses.length == 0 && !isLoading">
            Vui lòng cập nhật địa chỉ...
        </div>

        <div class="account-address-content" v-if="!isLoading">
            <div class="account-address-item" v-for="(address, index) in addresses">
                <div class="account-address-content">
                    <div class="account-address-head">
                        <div>{{ address.belongsTo }}</div>
                        <span v-if="address.isDefault">Mặc định</span>
                    </div>
                    <div class="account-address-text">
                        {{ address.phone }}<br>
                        {{ address.displayingAddress }}
                    </div>
                </div>
                <div class="account-address-action">
                    <div class="account-address-buttons">
                        <button data-bs-toggle="modal" :data-bs-target="`#update-address-modal`"
                            @click="getUpdatingAddress(address)">Cập nhật</button>
                        <button @click="deleteAddress(address)">Xóa</button>
                    </div>
                    <button class="account-address-button" v-if="!address.isDefault"
                        @click="updateToDefaultAddress(address)">Đặt làm mặc định</button>
                </div>
            </div>

            <!-- Add Modal -->
            <div class="modal fade" id="address-modal" tabindex="-1" aria-labelledby="exampleModalLabel"
                data-bs-backdrop="false" data-bs-focus="true" aria-hidden="false">
                <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
                    <div class="modal-content">
                        <div class="modal-header" style="z-index:1">
                            <div class="modal-title h3" id="exampleModalLabel">Thêm địa chỉ</div>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body" style="z-index:2">
                            <div class="grid">
                                <div class="grid-column">
                                    <span class="mx-2  text-secondary text-secondary">Tên người nhận</span>
                                    <input type="text" name="name" placeholder="Tên người nhận" v-model="customerName"
                                        class="form-control custom-cursor-default-hover" />
                                </div>
                                <div class="grid-column">
                                    <div class="phone-block">
                                        <span class="mx-2  text-secondary">Số điện thoại</span>
                                        <input type="text" name="phone" v-model="customerPhone" placeholder="01234xxxxx"
                                            autocomplete="off" class="form-control" />
                                    </div>
                                </div>
                                <div class="grid-column">
                                    <div class="address-block">
                                        <span class="mx-2  text-secondary">Địa chỉ</span>
                                        <input type="text" name="address" v-model="customerAddress"
                                            placeholder="Địa chỉ (ví dụ: 103 Vạn Phúc, phường Vạn Phúc)"
                                            autocomplete="off" class="form-control" />
                                    </div>
                                </div>
                            </div>
                            <div class="grid">
                                <div class="grid-column mobile--one-whole">
                                    <div dir="auto" class="v-select vue-select vs--single vs--searchable"
                                        name="nhanh_city">
                                        <span class="mx-2  text-secondary">Thành phố</span>
                                        <div @click="toggleCityDropdown" id="vs1-combobox" role="combobox"
                                            :aria-expanded="showCityDropdown" aria-owns="vs1-listbox"
                                            aria-label="Search for option" class="vs-dropdown-toggle">
                                            <div class="vs-selected-options">
                                                <span class="vs-selected"> {{ activeCity.name }}</span>
                                                <input aria-autocomplete="list" aria-labelledby="vs1-combobox"
                                                    aria-controls="vs1-listbox" type="search" autocomplete="off"
                                                    class="vs-search" readonly />
                                                <ul class="city-list" v-show="showCityDropdown" id="vs1-listbox"
                                                    role="listbox" aria-label="cities" style="z-index: 2;">
                                                    <li v-for="(city, index) in cities" class="city-option"
                                                        role="option" :id="'city-' + index"
                                                        @mouseover="setActiveCity(index)">
                                                        {{ city.name }}
                                                    </li>
                                                </ul>
                                            </div>

                                            <div class="vs-actions">
                                                <button type="button" title="Clear Selected" aria-label="Clear Selected"
                                                    class="vs-clear" style="display: none">
                                                    <svg xmlns="http://www.w3.org/2000/svg" width="10" height="10">
                                                        <path
                                                            d="M6.895455 5l2.842897-2.842898c.348864-.348863.348864-.914488 0-1.263636L9.106534.261648c-.348864-.348864-.914489-.348864-1.263636 0L5 3.104545 2.157102.261648c-.348863-.348864-.914488-.348864-1.263636 0L.261648.893466c-.348864.348864-.348864.914489 0 1.263636L3.104545 5 .261648 7.842898c-.348864.348863-.348864.914488 0 1.263636l.631818.631818c.348864.348864.914773.348864 1.263636 0L5 6.895455l2.842898 2.842897c.348863.348864.914772.348864 1.263636 0l.631818-.631818c.348864-.348864.348864-.914489 0-1.263636L6.895455 5z">
                                                        </path>
                                                    </svg>
                                                </button>
                                                <svg xmlns="http://www.w3.org/2000/svg" width="14" height="10"
                                                    role="presentation" class="vs-open-indicator">
                                                    <path
                                                        d="M9.211364 7.59931l4.48338-4.867229c.407008-.441854.407008-1.158247 0-1.60046l-.73712-.80023c-.407008-.441854-1.066904-.441854-1.474243 0L7 5.198617 2.51662.33139c-.407008-.441853-1.066904-.441853-1.474243 0l-.737121.80023c-.407008.441854-.407008 1.158248 0 1.600461l4.48338 4.867228L7 10l2.211364-2.40069z">
                                                    </path>
                                                </svg>
                                                <div class="vs-spinner" style="display: none">Loading...</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="grid-column mobile--one-whole">
                                    <span class="mx-2  text-secondary">Quận / Huyện</span>
                                    <div dir="auto" class="v-select vue-select vs--single vs--searchable"
                                        name="nhanh_district">
                                        <div @click="toggleDistrictDropdown" id="vs2-combobox" role="combobox"
                                            :aria-expanded="showDistrictDropdown" aria-owns="vs2-listbox"
                                            aria-label="Search for option" class="vs-dropdown-toggle">
                                            <div class="vs-selected-options">
                                                <span class="vs-selected"> {{ activeDistrict.name }}</span>
                                                <input aria-autocomplete="list" aria-labelledby="vs2-combobox"
                                                    aria-controls="vs2-listbox" type="search" autocomplete="off"
                                                    class="vs-search" readonly />
                                                <ul class="district-list" v-show="showDistrictDropdown" id="vs2-listbox"
                                                    role="listbox" aria-label="districts">
                                                    <li v-for="(district, index2) in districts" class="district-option"
                                                        role="option" :id="'district-' + index2"
                                                        @mouseover="setActiveDistrict(index2)" :key="index2">
                                                        {{ district.name }}
                                                    </li>
                                                </ul>
                                            </div>
                                            <div class="vs-actions">
                                                <button type="button" title="Clear Selected" aria-label="Clear Selected"
                                                    class="vs-clear" style="display: none">
                                                    <svg xmlns="http://www.w3.org/2000/svg" width="10" height="10">
                                                        <path
                                                            d="M6.895455 5l2.842897-2.842898c.348864-.348863.348864-.914488 0-1.263636L9.106534.261648c-.348864-.348864-.914489-.348864-1.263636 0L5 3.104545 2.157102.261648c-.348863-.348864-.914488-.348864-1.263636 0L.261648.893466c-.348864.348864-.348864.914489 0 1.263636L3.104545 5 .261648 7.842898c-.348864.348863-.348864.914488 0 1.263636l.631818.631818c.348864.348864.914773.348864 1.263636 0L5 6.895455l2.842898 2.842897c.348863.348864.914772.348864 1.263636 0l.631818-.631818c.348864-.348864.348864-.914489 0-1.263636L6.895455 5z">
                                                        </path>
                                                    </svg>
                                                </button>
                                                <svg xmlns="http://www.w3.org/2000/svg" width="14" height="10"
                                                    role="presentation" class="vs-open-indicator">
                                                    <path
                                                        d="M9.211364 7.59931l4.48338-4.867229c.407008-.441854.407008-1.158247 0-1.60046l-.73712-.80023c-.407008-.441854-1.066904-.441854-1.474243 0L7 5.198617 2.51662.33139c-.407008-.441853-1.066904-.441853-1.474243 0l-.737121.80023c-.407008.441854-.407008 1.158248 0 1.600461l4.48338 4.867228L7 10l2.211364-2.40069z">
                                                    </path>
                                                </svg>
                                                <div class="vs-spinner" style="display: none">Loading...</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="grid-column mobile--one-whole">
                                    <span class="mx-2  text-secondary">Phường / Xã</span>
                                    <div dir="auto" class="v-select vue-select vs--single vs--searchable"
                                        name="nhanh_ward" id="nhanh_ward">
                                        <div @click="toggleVillageDropdown" id="vs3-combobox" role="combobox"
                                            :aria-expanded="showVillageDropdown" aria-owns="vs3-listbox"
                                            aria-label="Search for option" class="vs-dropdown-toggle">
                                            <div class="vs-selected-options">
                                                <span class="vs-selected"> {{ activeVillage.name }}</span>
                                                <input aria-autocomplete="list" aria-labelledby="vs3-combobox"
                                                    aria-controls="vs3-listbox" type="search" autocomplete="off"
                                                    class="vs-search" readonly />
                                                <ul class="village-list" v-show="showVillageDropdown" id="vs3-listbox"
                                                    role="listbox" aria-label="villages">
                                                    <li v-for="(village, index) in villages" class="village-option"
                                                        role="option" :id="'village-' + index"
                                                        @mouseover="setActiveVillage(index)">
                                                        {{ village.name }}
                                                    </li>
                                                </ul>
                                            </div>

                                            <div class="vs-actions">
                                                <button type="button" title="Clear Selected" aria-label="Clear Selected"
                                                    class="vs-clear" style="display: none">
                                                    <svg xmlns="http://www.w3.org/2000/svg" width="10" height="10">
                                                        <path
                                                            d="M6.895455 5l2.842897-2.842898c.348864-.348863.348864-.914488 0-1.263636L9.106534.261648c-.348864-.348864-.914489-.348864-1.263636 0L5 3.104545 2.157102.261648c-.348863-.348864-.914488-.348864-1.263636 0L.261648.893466c-.348864.348864-.348864.914489 0 1.263636L3.104545 5 .261648 7.842898c-.348864.348863-.348864.914488 0 1.263636l.631818.631818c.348864.348864.914773.348864 1.263636 0L5 6.895455l2.842898 2.842897c.348863.348864.914772.348864 1.263636 0l.631818-.631818c.348864-.348864.348864-.914489 0-1.263636L6.895455 5z">
                                                        </path>
                                                    </svg>
                                                </button>
                                                <svg xmlns="http://www.w3.org/2000/svg" width="14" height="10"
                                                    role="presentation" class="vs-open-indicator">
                                                    <path
                                                        d="M9.211364 7.59931l4.48338-4.867229c.407008-.441854.407008-1.158247 0-1.60046l-.73712-.80023c-.407008-.441854-1.066904-.441854-1.474243 0L7 5.198617 2.51662.33139c-.407008-.441853-1.066904-.441853-1.474243 0l-.737121.80023c-.407008.441854-.407008 1.158248 0 1.600461l4.48338 4.867228L7 10l2.211364-2.40069z">
                                                    </path>
                                                </svg>
                                                <div class="vs-spinner" style="display: none">Loading...</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer" style="z-index:1">
                            <button type="button" class="btn-save btn" data-bs-dismiss="modal"
                                @click="addNewAddress">Thêm</button>
                            <button type="button" class="btn btn-cancel" data-bs-dismiss="modal">Trở lại</button>
                            <!-- <button type="button" class="btn btn-primary btn-save">Lưu</button> -->
                        </div>
                    </div>
                </div>
            </div>

            <!-- Update Modal -->
            <div class="modal fade" id="update-address-modal" tabindex="-1" aria-labelledby="updateModal"
                data-bs-backdrop="false" data-bs-focus="true" aria-hidden="false">
                <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
                    <div class="modal-content">
                        <div class="modal-header" style="z-index:1">
                            <div class="modal-title h3" id="updateModal">Cập nhật địa chỉ</div>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body" style="z-index:2">
                            <div class="grid">
                                <div class="grid-column">
                                    <span class="mx-2  text-secondary text-secondary">Tên người nhận</span>
                                    <input type="text" name="name" placeholder="Tên người nhận"
                                        v-model="updatingAddress.belongsTo"
                                        class="form-control custom-cursor-default-hover" />
                                </div>
                                <div class="grid-column">
                                    <div class="phone-block">
                                        <span class="mx-2  text-secondary">Số điện thoại</span>
                                        <input type="text" name="phone" v-model="updatingAddress.phone"
                                            placeholder="01234xxxxx" autocomplete="off" class="form-control" />
                                    </div>
                                </div>
                                <div class="grid-column">
                                    <div class="address-block">
                                        <span class="mx-2  text-secondary">Địa chỉ</span>
                                        <input type="text" name="address" v-model="updatingAddress.address"
                                            placeholder="Địa chỉ (ví dụ: 103 Vạn Phúc, phường Vạn Phúc)"
                                            autocomplete="off" class="form-control" />
                                    </div>
                                </div>
                            </div>
                            <div class="grid">
                                <div class="grid-column mobile--one-whole">
                                    <div dir="auto" class="v-select vue-select vs--single vs--searchable"
                                        name="nhanh_city">
                                        <span class="mx-2  text-secondary">Thành phố</span>
                                        <div @click="toggleCityDropdown" id="vs1-combobox" role="combobox"
                                            :aria-expanded="showCityDropdown" aria-owns="vs1-listbox"
                                            aria-label="Search for option" class="vs-dropdown-toggle">
                                            <div class="vs-selected-options">
                                                <span class="vs-selected"> {{ activeCity.name }}</span>
                                                <input aria-autocomplete="list" aria-labelledby="vs1-combobox"
                                                    aria-controls="vs1-listbox" type="search" autocomplete="off"
                                                    class="vs-search" readonly />
                                                <ul class="city-list" v-show="showCityDropdown" id="vs1-listbox"
                                                    role="listbox" aria-label="cities" style="z-index: 2;">
                                                    <li v-for="(city, index) in cities" class="city-option"
                                                        role="option" :id="'city-' + index"
                                                        @mouseover="setActiveCity(index)">
                                                        {{ city.name }}
                                                    </li>
                                                </ul>
                                            </div>

                                            <div class="vs-actions">
                                                <button type="button" title="Clear Selected" aria-label="Clear Selected"
                                                    class="vs-clear" style="display: none">
                                                    <svg xmlns="http://www.w3.org/2000/svg" width="10" height="10">
                                                        <path
                                                            d="M6.895455 5l2.842897-2.842898c.348864-.348863.348864-.914488 0-1.263636L9.106534.261648c-.348864-.348864-.914489-.348864-1.263636 0L5 3.104545 2.157102.261648c-.348863-.348864-.914488-.348864-1.263636 0L.261648.893466c-.348864.348864-.348864.914489 0 1.263636L3.104545 5 .261648 7.842898c-.348864.348863-.348864.914488 0 1.263636l.631818.631818c.348864.348864.914773.348864 1.263636 0L5 6.895455l2.842898 2.842897c.348863.348864.914772.348864 1.263636 0l.631818-.631818c.348864-.348864.348864-.914489 0-1.263636L6.895455 5z">
                                                        </path>
                                                    </svg>
                                                </button>
                                                <svg xmlns="http://www.w3.org/2000/svg" width="14" height="10"
                                                    role="presentation" class="vs-open-indicator">
                                                    <path
                                                        d="M9.211364 7.59931l4.48338-4.867229c.407008-.441854.407008-1.158247 0-1.60046l-.73712-.80023c-.407008-.441854-1.066904-.441854-1.474243 0L7 5.198617 2.51662.33139c-.407008-.441853-1.066904-.441853-1.474243 0l-.737121.80023c-.407008.441854-.407008 1.158248 0 1.600461l4.48338 4.867228L7 10l2.211364-2.40069z">
                                                    </path>
                                                </svg>
                                                <div class="vs-spinner" style="display: none">Loading...</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="grid-column mobile--one-whole">
                                    <span class="mx-2  text-secondary">Quận / Huyện</span>
                                    <div dir="auto" class="v-select vue-select vs--single vs--searchable"
                                        name="nhanh_district">
                                        <div @click="toggleDistrictDropdown" id="vs2-combobox" role="combobox"
                                            :aria-expanded="showDistrictDropdown" aria-owns="vs2-listbox"
                                            aria-label="Search for option" class="vs-dropdown-toggle">
                                            <div class="vs-selected-options">
                                                <span class="vs-selected"> {{ activeDistrict.name }}</span>
                                                <input aria-autocomplete="list" aria-labelledby="vs2-combobox"
                                                    aria-controls="vs2-listbox" type="search" autocomplete="off"
                                                    class="vs-search" readonly />
                                                <ul class="district-list" v-show="showDistrictDropdown" id="vs2-listbox"
                                                    role="listbox" aria-label="districts">
                                                    <li v-for="(district, index2) in districts" class="district-option"
                                                        role="option" :id="'district-' + index2"
                                                        @mouseover="setActiveDistrict(index2)" :key="index2">
                                                        {{ district.name }}
                                                    </li>
                                                </ul>
                                            </div>
                                            <div class="vs-actions">
                                                <button type="button" title="Clear Selected" aria-label="Clear Selected"
                                                    class="vs-clear" style="display: none">
                                                    <svg xmlns="http://www.w3.org/2000/svg" width="10" height="10">
                                                        <path
                                                            d="M6.895455 5l2.842897-2.842898c.348864-.348863.348864-.914488 0-1.263636L9.106534.261648c-.348864-.348864-.914489-.348864-1.263636 0L5 3.104545 2.157102.261648c-.348863-.348864-.914488-.348864-1.263636 0L.261648.893466c-.348864.348864-.348864.914489 0 1.263636L3.104545 5 .261648 7.842898c-.348864.348863-.348864.914488 0 1.263636l.631818.631818c.348864.348864.914773.348864 1.263636 0L5 6.895455l2.842898 2.842897c.348863.348864.914772.348864 1.263636 0l.631818-.631818c.348864-.348864.348864-.914489 0-1.263636L6.895455 5z">
                                                        </path>
                                                    </svg>
                                                </button>
                                                <svg xmlns="http://www.w3.org/2000/svg" width="14" height="10"
                                                    role="presentation" class="vs-open-indicator">
                                                    <path
                                                        d="M9.211364 7.59931l4.48338-4.867229c.407008-.441854.407008-1.158247 0-1.60046l-.73712-.80023c-.407008-.441854-1.066904-.441854-1.474243 0L7 5.198617 2.51662.33139c-.407008-.441853-1.066904-.441853-1.474243 0l-.737121.80023c-.407008.441854-.407008 1.158248 0 1.600461l4.48338 4.867228L7 10l2.211364-2.40069z">
                                                    </path>
                                                </svg>
                                                <div class="vs-spinner" style="display: none">Loading...</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="grid-column mobile--one-whole">
                                    <span class="mx-2  text-secondary">Phường / Xã</span>
                                    <div dir="auto" class="v-select vue-select vs--single vs--searchable"
                                        name="nhanh_ward" id="nhanh_ward">
                                        <div @click="toggleVillageDropdown" id="vs3-combobox" role="combobox"
                                            :aria-expanded="showVillageDropdown" aria-owns="vs3-listbox"
                                            aria-label="Search for option" class="vs-dropdown-toggle">
                                            <div class="vs-selected-options">
                                                <span class="vs-selected"> {{ activeVillage.name }}</span>
                                                <input aria-autocomplete="list" aria-labelledby="vs3-combobox"
                                                    aria-controls="vs3-listbox" type="search" autocomplete="off"
                                                    class="vs-search" readonly />
                                                <ul class="village-list" v-show="showVillageDropdown" id="vs3-listbox"
                                                    role="listbox" aria-label="villages">
                                                    <li v-for="(village, index) in villages" class="village-option"
                                                        role="option" :id="'village-' + index"
                                                        @mouseover="setActiveVillage(index)">
                                                        {{ village.name }}
                                                    </li>
                                                </ul>
                                            </div>

                                            <div class="vs-actions">
                                                <button type="button" title="Clear Selected" aria-label="Clear Selected"
                                                    class="vs-clear" style="display: none">
                                                    <svg xmlns="http://www.w3.org/2000/svg" width="10" height="10">
                                                        <path
                                                            d="M6.895455 5l2.842897-2.842898c.348864-.348863.348864-.914488 0-1.263636L9.106534.261648c-.348864-.348864-.914489-.348864-1.263636 0L5 3.104545 2.157102.261648c-.348863-.348864-.914488-.348864-1.263636 0L.261648.893466c-.348864.348864-.348864.914489 0 1.263636L3.104545 5 .261648 7.842898c-.348864.348863-.348864.914488 0 1.263636l.631818.631818c.348864.348864.914773.348864 1.263636 0L5 6.895455l2.842898 2.842897c.348863.348864.914772.348864 1.263636 0l.631818-.631818c.348864-.348864.348864-.914489 0-1.263636L6.895455 5z">
                                                        </path>
                                                    </svg>
                                                </button>
                                                <svg xmlns="http://www.w3.org/2000/svg" width="14" height="10"
                                                    role="presentation" class="vs-open-indicator">
                                                    <path
                                                        d="M9.211364 7.59931l4.48338-4.867229c.407008-.441854.407008-1.158247 0-1.60046l-.73712-.80023c-.407008-.441854-1.066904-.441854-1.474243 0L7 5.198617 2.51662.33139c-.407008-.441853-1.066904-.441853-1.474243 0l-.737121.80023c-.407008.441854-.407008 1.158248 0 1.600461l4.48338 4.867228L7 10l2.211364-2.40069z">
                                                    </path>
                                                </svg>
                                                <div class="vs-spinner" style="display: none">Loading...</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer" style="z-index:1">
                            <button type="button" class="btn-save btn" data-bs-dismiss="modal"
                                @click="updateAddress">Lưu chỉnh sửa</button>
                            <button type="button" class="btn btn-cancel" data-bs-dismiss="modal">Trở lại</button>
                            <!-- <button type="button" class="btn btn-primary btn-save">Lưu</button> -->
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<style scoped>
.account-content {
    position: relative;
    /* display: flex; */
    align-items: center;
    padding: 3rem 3rem;
    transition: all .2s;
    border-radius: 0.5rem;
    font-size: 1rem;
    box-sizing: border-box;
    background-color: white;
    width: 100%;
    box-shadow: rgba(0, 0, 0, 0.24) 0px 3px 8px;
}

.account-page-title {
    font-size: 2.25em;
    font-weight: 400;
}

.account-address .account-page-title {
    margin-bottom: 0;
}

.account-address {
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding-bottom: 2rem;
    border-bottom: 1px solid rgba(0, 0, 0, .1333333333);
}

.account-page-button {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 54px;
    padding: 0 40px;
    border-radius: 100vmax;
    color: #fff;
    text-transform: uppercase;
    border: 0;
    background-color: #000;
    transition: all .3s;
    letter-spacing: .125rem;
    font-size: 1rem;
    cursor: pointer;
}

.account-page-button:hover {
    background-color: #2f5acf;
    color: #fff;
    border: 0;
}

.account-address-title {
    font-size: 1.5rem;
    padding-top: 1rem;
    padding-bottom: 1rem;
}

.account-address-item {
    display: flex;
    justify-content: space-between;
    padding-bottom: 1.5rem;
    margin-bottom: 1.5rem;
    border-bottom: 1px solid rgba(0, 0, 0, .1333333333);
}

.account-address-content {
    flex: 1;
}

.account-address-text {
    font-size: 1rem;
    color: rgba(0, 0, 0, .6);
}

.account-address-head {
    display: flex;
    align-items: center;
    font-size: 1rem;
    margin-bottom: 0.5rem;
}

.account-address-action {
    display: flex;
    flex-flow: column;
}

.account-address-buttons {
    display: flex;
    align-items: flex-start;
    justify-content: flex-end;
    flex: 1;
}

.account-address-buttons button {
    padding: 0;
    background-color: transparent;
    border: 0;
    color: #2f5acf;
}

.account-address-buttons button:hover {
    color: #000;
}

.account-address-buttons button:last-of-type {
    padding-left: 1rem;
    margin-left: 1rem;
    border-left: 1px solid rgba(0, 0, 0, .1333333333);
}

.account-address-button {
    display: flex;
    align-items: center;
    height: 34px;
    padding-left: 2rem;
    padding-right: 2rem;
    background-color: #fff;
    color: #000;
    border-radius: 100vmax;
    border: 1px solid #000;
    cursor: pointer;
    transition: all .3s;
}

.account-address-button:hover {
    background-color: #000;
    color: #fff;
}

.account-address-head span {
    display: flex;
    justify-content: center;
    align-items: center;
    border: 1px solid rgba(0, 0, 0, .1333333333);
    border-radius: 100vmax;
    padding: 4px 10px 5px;
    font-size: .75rem;
    margin-left: 0.5rem;
}

.account-address-head span:before {
    content: "";
    width: 0.625rem;
    height: 0.625rem;
    display: block;
    background-image: url(https://mcdn.coolmate.me/image/September2023/mceclip0_65.png);
    background-repeat: no-repeat;
    background-size: contain;
    background-position: 50%;
    margin-right: 0.25rem;
}


.grid {
    display: flex;
    display: -webkit-flex;
    -moz-flex-direction: row;
    flex-direction: row;
    flex-wrap: wrap;
    margin-left: -9px;
    margin-right: -9px;
    padding: 0;
    position: relative;
    float: none;
}

.six-twelfths {
    width: 50%;
}

.grid-column {
    position: relative;
    box-sizing: border-box;
    min-height: 1px;
    vertical-align: top;
    margin-left: 0 !important;
    margin-right: 0 !important;
    padding: 9px;
    padding-top: 0px;
    width: 100%;
}

.form-control,
.vue-select .vs-dropdown-toggle {
    background: #fff;
    border: 1px solid #d9d9d9;
    box-sizing: border-box;
    border-radius: 16px;
    height: 40px;
    width: 100%;
    padding: 5px 20px;
    transition: all 0.2s;
}

.grid:after {
    content: "";
    display: table;
    clear: both;
}

.v-select {
    position: relative;
    font-family: inherit;
}

.vs--searchable .vs-dropdown-toggle {
    cursor: text;
}

.vue-select .vs-dropdown-toggle {
    padding: 5px 10px 5px 20px;
}

.form-control,
.vue-select .vs-dropdown-toggle {
    background: #fff;
    border: 1px solid #d9d9d9;
    box-sizing: border-box;
    border-radius: 16px;
    height: 40px;
    width: 100%;
    padding: 5px 20px;
    transition: all 0.2s;
}

.vs-dropdown-toggle {
    -webkit-appearance: none;
    -moz-appearance: none;
    appearance: none;
    display: flex;
    padding: 0 0 4px;
    background: 0 0;
    border: 1px solid rgba(60, 60, 60, 0.26);
    border-radius: 4px;
    white-space: normal;
}

.vue-select .vs-selected,
.vue-select .vs-selected-options {
    padding: 0;
    margin: 0;
    align-items: center;
}

.vs-selected-options {
    display: flex;
    flex-basis: 100%;
    flex-grow: 1;
    flex-wrap: wrap;
    padding: 0 2px;
    position: relative;
}

.vs--single .vs-selected {
    background-color: transparent;
    border-color: transparent;
}

.vue-select .vs-selected,
.vue-select .vs-selected-options {
    padding: 0;
    margin: 0;
    align-items: center;
}

.vs-selected {
    display: flex;
    align-items: center;
    background-color: #f0f0f0;
    border: 1px solid rgba(60, 60, 60, 0.26);
    border-radius: 4px;
    color: #333;
    line-height: 1.4;
    margin: 4px 2px 0;
    padding: 0 0.25em;
    z-index: 0;
}

.vue-select .vs-search {
    margin: 0;
    padding: 0;
}

.vs-search,
.vs-search:focus {
    -webkit-appearance: none;
    -moz-appearance: none;
    appearance: none;
    line-height: 1.4;
    font-size: 1em;
    border: 1px solid transparent;
    border-left: none;
    outline: none;
    margin: 4px 0 0;
    padding: 0 7px;
    background: 0 0;
    box-shadow: none;
    width: 0;
    max-width: 100%;
    flex-grow: 1;
    z-index: 1;
}

.vue-select .vs-selected {
    display: -webkit-box;
    -webkit-line-clamp: 1;
    -webkit-box-orient: vertical;
    overflow: hidden;
    text-overflow: ellipsis;
}

.vs-actions {
    display: flex;
    align-items: center;
    padding: 4px 6px 0 3px;
}

.vs-clear {
    fill: rgba(60, 60, 60, 0.5);
    padding: 0;
    border: 0;
    background-color: transparent;
    cursor: pointer;
    margin-right: 8px;
}

.vs-spinner {
    align-self: center;
    opacity: 0;
    font-size: 5px;
    text-indent: -9999em;
    overflow: hidden;
    border: 0.9em solid hsla(0, 0%, 39.2%, 0.1);
    border-left-color: rgba(60, 60, 60, 0.45);
    transform: translateZ(0);
    animation: vSelectSpinner 1.1s linear infinite;
    transition: opacity 0.1s;
}

.form-control:focus,
.form-control:active .vs-dropdown-toggle:focus,
.vs-dropdown-toggle:active {
    border-color: inherit !important;
    -webkit-box-shadow: none !important;
    box-shadow: none !important;
    outline: none !important;
    border: 1px solid #2f5acf !important;
}

.seven-twelfths {
    width: 58.333%;
}

.six-twelfths {
    width: 50%;
}

.city-list,
.district-list,
.village-list,
.shipping-service-list {
    display: block;
    background-color: white;
    z-index: 99;
    width: 100%;
    margin-top: 20px;
    overflow-y: scroll;
    max-height: 150px;
    cursor: pointer;
}

.village-list {
    max-height: 100px;
}

.city-option,
.district-option,
.village-option,
.shipping-service-option {
    margin: 2px 0px 2px;
    font-size: 14px;
    padding-bottom: 2px;
    padding-left: 5px;
    z-index: 100;
}

.city-option:hover,
.district-option:hover,
.village-option:hover,
.shipping-service-option:hover {
    background-color: #333;
    color: #fff;
}

.vs-dropdown-toggle:hover,
input:hover {
    cursor: pointer;
}

.modal {
    overflow: visible;
}

.modal-header {
    padding: 9px;
    padding-left: 20px;
}

.modal-body {
    padding: 9px 15px;
    overflow-y: visible;
}

.modal-content {
    overflow: visible;
}

.btn {
    height: auto;
    padding: 0.5rem 1rem;
    border-radius: 10px;
    line-height: 1;
    box-sizing: border-box;
    font-family: "CriteriaCF", "Pangea", sans-serif;
    margin-right: 10px;
    border: 1px solid #252525;
    cursor: pointer;
}


.btn-cancel:hover {
    background-color: #181819;
    color: #e4dddd;
    border: 1px solid #232325;
}

.btn-save {
    background-color: #2f5acf;
    color: #e4dddd;
}

.btn-save:hover {
    background-color: #143aa2;
    color: #e4dddd;
}

.loader {
    display: block;
    border-radius: 50%;
    position: relative;
    animation: rotate 1s linear infinite;
    width: 200px;
    height: 200px;
    background: rgba(255, 255, 255, 0.5);
    position: fixed;
    top: 40%;
    left: 40%;
    z-index: 100;
}

.loader::before,
.loader::after {
    content: "";
    box-sizing: border-box;
    position: absolute;
    inset: 0px;
    border-radius: 50%;
    border: 20px solid #e5e3e3;
    animation: prixClipFix 2s linear infinite;
    z-index: 1000;
}

.loader::after {
    border-color: #2424be;
    animation: prixClipFix 2s linear infinite, rotate 0.5s linear infinite reverse;
    inset: 6px;
    z-index: 1000;
}

@keyframes rotate {
    0% {
        transform: rotate(0deg)
    }

    100% {
        transform: rotate(360deg)
    }
}

@keyframes prixClipFix {
    0% {
        clip-path: polygon(50% 50%, 0 0, 0 0, 0 0, 0 0, 0 0)
    }

    25% {
        clip-path: polygon(50% 50%, 0 0, 100% 0, 100% 0, 100% 0, 100% 0)
    }

    50% {
        clip-path: polygon(50% 50%, 0 0, 100% 0, 100% 100%, 100% 100%, 100% 100%)
    }

    75% {
        clip-path: polygon(50% 50%, 0 0, 100% 0, 100% 100%, 0 100%, 0 100%)
    }

    100% {
        clip-path: polygon(50% 50%, 0 0, 100% 0, 100% 100%, 0 100%, 0 0)
    }
}
</style>