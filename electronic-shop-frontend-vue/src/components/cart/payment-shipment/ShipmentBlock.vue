<script lang="ts">
import { CartService } from '@/services/cart.service';
import { UserService, type Address, type User } from "@/services/user.service";
import { inject, onMounted, ref, type Ref } from "vue";

export type Shipment = {
  shipCost: number,
  method: string,
  status: string,
}

export default {
  setup() {

    const { cartService }: { cartService: CartService } = inject('cartService')!;

    const showCityDropdown = ref(false);
    const showDistrictDropdown = ref(false);
    const showVillageDropdown = ref(false);
    const showShippingServiceDropdown = ref(false);

    const activeCityIndex = ref<number | null>(null);
    const activeDistrictIndex = ref<number | null>(null);
    const activeVillageIndex = ref<number | null>(null);
    const activeShippingServiceIndex = ref<number | null>(null);

    const activeCity = ref<{ name: string, id: number }>({ name: "Chọn Tỉnh / Thành", id: -1 });
    const activeDistrict = ref<{ name: string, id: number }>({ name: "Chọn Quận / Huyện", id: -1 });
    const activeVillage = ref<{ name: string, id: number, code: string }>({ name: "Chọn Phường / Xã", id: -1, code: '-1' });
    const activeShippingService = ref<any>({ short_name: "Chọn dịch vụ vận chuyển" });

    let orderShipment: Shipment = {
      shipCost: 30000,
      method: "road",
      status: "pending"
    }

    if (localStorage.getItem('orderShipment') != null) {
      orderShipment = JSON.parse(localStorage.getItem('orderShipment')!);
    } else {
      console.log(JSON.stringify(orderShipment))
      localStorage.setItem('orderShipment', JSON.stringify(orderShipment));
    }

    const customerInfo = JSON.parse(localStorage.getItem('account')!);

    var cities: { name: string, id: number }[] = [];
    const districts: Ref<{ name: string, id: number }[]> = ref<{ name: string, id: number }[]>([]);
    const villages: Ref<{ name: string, id: number, code: string }[]> = ref<{ name: string, id: number, code: string }[]>([]);
    const shippingServices: Ref<any[]> = ref([]);

    const setActiveCity = (index: number) => {
      activeCityIndex.value = index;
    };

    const setActiveDistrict = (index: number) => {
      activeDistrictIndex.value = index;
    };

    const setActiveVillage = (index: number) => {
      activeVillageIndex.value = index;
    };

    const setActiveShippingService = (index: number) => {
      activeShippingServiceIndex.value = index;
    };

    const isLoading = ref(true)

    const addresses = ref<Address[]>([]);
    let userService = new UserService();

    const toggleCityDropdown = async () => {
      showCityDropdown.value = !showCityDropdown.value;

      if (activeCityIndex.value == null && activeCity.value.name != "Chọn Tỉnh / Thành") return;

      if (!showCityDropdown.value) {
        activeCity.value = cities[activeCityIndex.value!];

        let response = (await cartService.getDistrict(activeCity.value.id)).data.data.map(
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

        let response = (await cartService.getWard(activeDistrict.value.id)).data.data.map(
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
        let response = await cartService.getShippingService(1572, activeDistrict.value.id); // 1572 : Quận Ninh Kiều

        shippingServices.value = response.data.data;
        console.log(shippingServices.value[0].service_id)

        let feeResponse = await cartService.getShipCost(1572, "550113", shippingServices.value[0].service_id, activeDistrict.value.id, activeVillage.value.code);

        console.log("fee: ", feeResponse.data.data.total);

        cartService.shipCost.value = feeResponse.data.data.total;
        cartService.subTotal.value = cartService.total.value + cartService.shipCost.value - cartService.discount.value;

      }
    };

    const toggleShippingServiceDropdown = async () => {

      showShippingServiceDropdown.value = !showShippingServiceDropdown.value;

      if (activeShippingServiceIndex.value === null) return;

      if (activeShippingServiceIndex.value == null && activeShippingService.value.short_name != "Chọn dịch vụ vận chuyển") return;

      if (!showShippingServiceDropdown.value) {
        activeShippingService.value = shippingServices.value[activeShippingServiceIndex.value!];
        console.log(activeShippingService.value)
      }

      let response = await cartService.getShipCost(1572, "550113", activeShippingService.value.service_id, activeDistrict.value.id, activeVillage.value.code);

      console.log("fee: ", response.data.data.total);

      cartService.shipCost.value = response.data.data.total;
      cartService.subTotal.value = cartService.total.value + cartService.shipCost.value - cartService.discount.value;

    };

    const addressFromAddressBook = ref<Address>({
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
    });;

    const getAddressFromAddressBook = async () => {

      addressFromAddressBook.value = (await userService.getDefaultAddressOfCustomer(customerInfo.id)).data[0];

      let city = await userService.getCityById(addressFromAddressBook.value.cityId);
      let maxLength = 0;
      city.NameExtension.forEach(province => {
        if (province.length > maxLength) {
          maxLength = province.length;
          city.ProvinceName = province;
        }
      });

      let district = await userService.getDistrictById(addressFromAddressBook.value.cityId, addressFromAddressBook.value.districtId);

      let ward = await userService.getWardById(addressFromAddressBook.value.districtId, addressFromAddressBook.value.wardId);

      activeCity.value = { name: city.ProvinceName, id: Number(addressFromAddressBook.value.cityId) };
      activeDistrict.value = { name: district.DistrictName, id: Number(addressFromAddressBook.value.districtId) };
      activeVillage.value = { name: ward.WardName, id: ward.id, code: addressFromAddressBook.value.wardId };

      activeCityIndex.value = cities.findIndex(x => x.id.toString() == addressFromAddressBook.value.cityId);

      districts.value = (await userService.getDistrict(activeCity.value.id.toString())).data.data.map(
        res => { return { name: res.DistrictName, id: res.DistrictID } }
      );

      districts.value.sort(sortByName);

      activeDistrictIndex.value = districts.value.findIndex(x => x.id.toString() == addressFromAddressBook.value.districtId);

      villages.value = (await userService.getWard(activeDistrict.value.id.toString())).data.data.map(
        res => { return { name: res.WardName, id: res.WardID, code: res.WardCode } }
      );

      villages.value.sort(sortByName);

      activeVillageIndex.value = villages.value.findIndex(x => x.code.toString() == addressFromAddressBook.value.wardId);

      let response = await cartService.getShippingService(1572, activeDistrict.value.id); // 1572 : Quận Ninh Kiều

      shippingServices.value = response.data.data;
      console.log(shippingServices.value[0].service_id)

      let feeResponse = await cartService.getShipCost(1572, "550113", shippingServices.value[0].service_id, activeDistrict.value.id, activeVillage.value.code);

      console.log("fee: ", feeResponse.data.data.total);

      cartService.shipCost.value = feeResponse.data.data.total;
      cartService.subTotal.value = cartService.total.value + cartService.shipCost.value - cartService.discount.value;

    }

    const getAddressesByCustomerId = async () => {

      isLoading.value = true;

      let data = (await userService.getAddressesByCustomerId(customerInfo.id)).data;

      data.reverse().forEach(async (address, index) => {
        let city = await userService.getCityById(address.cityId)

        let district = await userService.getDistrictById(address.cityId, address.districtId)

        let ward = await userService.getWardById(address.districtId, address.wardId)

        address.displayingAddress = address.address + ', ' + ward.WardName + ', ' + district.DistrictName + ', ' + city.ProvinceName;

        if (address.isDefault) {
          data.splice(index, 1);
          data.unshift(address);
        }
      })


      setTimeout(() => {
        addresses.value = data;
        console.log(addresses.value)
      }, 500);
    }

    const choseAddressOption = async (event: MouseEvent) => {
      addressFromAddressBook.value = addresses.value[(event.target as HTMLInputElement).value];

      let city = await userService.getCityById(addressFromAddressBook.value.cityId);
      let maxLength = 0;
      city.NameExtension.forEach(province => {
        if (province.length > maxLength) {
          maxLength = province.length;
          city.ProvinceName = province;
        }
      });

      let district = await userService.getDistrictById(addressFromAddressBook.value.cityId, addressFromAddressBook.value.districtId);

      let ward = await userService.getWardById(addressFromAddressBook.value.districtId, addressFromAddressBook.value.wardId);

      activeCity.value = { name: city.ProvinceName, id: Number(addressFromAddressBook.value.cityId) };
      activeDistrict.value = { name: district.DistrictName, id: Number(addressFromAddressBook.value.districtId) };
      activeVillage.value = { name: ward.WardName, id: ward.id, code: addressFromAddressBook.value.wardId };

      activeCityIndex.value = cities.findIndex(x => x.id.toString() == addressFromAddressBook.value.cityId);

      districts.value = (await userService.getDistrict(activeCity.value.id.toString())).data.data.map(
        res => { return { name: res.DistrictName, id: res.DistrictID } }
      );

      districts.value.sort(sortByName);

      activeDistrictIndex.value = districts.value.findIndex(x => x.id.toString() == addressFromAddressBook.value.districtId);

      villages.value = (await userService.getWard(activeDistrict.value.id.toString())).data.data.map(
        res => { return { name: res.WardName, id: res.WardID, code: res.WardCode } }
      );

      villages.value.sort(sortByName);

      activeVillageIndex.value = villages.value.findIndex(x => x.code.toString() == addressFromAddressBook.value.wardId);

      let response = await cartService.getShippingService(1572, activeDistrict.value.id); // 1572 : Quận Ninh Kiều

      shippingServices.value = response.data.data;
      console.log(shippingServices.value[0].service_id)

      let feeResponse = await cartService.getShipCost(1572, "550113", shippingServices.value[0].service_id, activeDistrict.value.id, activeVillage.value.code);

      console.log("fee: ", feeResponse.data.data.total);

      cartService.shipCost.value = feeResponse.data.data.total;
      cartService.subTotal.value = cartService.total.value + cartService.shipCost.value - cartService.discount.value;

    }

    onMounted(async () => {
      isLoading.value = true;
      // data.forEach((city) => cities.push(city.name));
      const response = await cartService.getCity();

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

      getAddressFromAddressBook();
      getAddressesByCustomerId();

      setTimeout(() => {
        isLoading.value = false;
      }, 1500);
    });

    const sortByName = (a, b) => {
      if (a.name > b.name) {
        return 1;
      }

      if (a.name < b.name) {
        return -1;
      }

      return 0;
    }

    return {
      customerInfo,
      toggleCityDropdown,
      toggleDistrictDropdown,
      toggleVillageDropdown,
      showCityDropdown,
      showDistrictDropdown,
      showVillageDropdown,
      cities,
      districts,
      villages,
      setActiveCity,
      setActiveDistrict,
      setActiveVillage,
      activeCity,
      activeDistrict,
      activeVillage,
      showShippingServiceDropdown,
      shippingServices,
      activeShippingService,
      toggleShippingServiceDropdown,
      setActiveShippingService,
      isLoading,
      getAddressFromAddressBook,
      getAddressesByCustomerId,
      addressFromAddressBook,
      addresses,
      choseAddressOption
    };
  },
};
</script>

<template>
  <div class="loader-container" v-if="isLoading"><span class="loader"></span></div>
  <div class="title-with-actions">
    <div class="title">Thông tin vận chuyển</div>
    <div class="action">
      <a data-bs-toggle="modal" :data-bs-target="`#address-modal`" @click="" class="flex align--center"><img
          src="https://www.coolmate.me/images/address_book_icon.svg" alt="address_book_icon"
          class="address_book_icon" />
        Chọn từ sổ địa chỉ
      </a>
    </div>
  </div>
  <div id="customer-info-block">
    <div class="grid">
      <div class="grid-column six-twelfths">
        <input type="text" name="full_name" placeholder="Họ tên" v-model="addressFromAddressBook.belongsTo"
          class="form-control" />
      </div>
      <div class="grid-column six-twelfths">
        <input type="tel" name="phone" placeholder="Số điện thoại" v-model="addressFromAddressBook.phone"
          class="form-control" />
      </div>
    </div>
    <div class="grid">
      <div class="grid-column">
        <input type="email" name="email" placeholder="Email" v-model="customerInfo.email"
          class="form-control custom-cursor-default-hover" />
      </div>
      <div class="grid-column">
        <div class="address-block">
          <input type="text" name="address" v-model="addressFromAddressBook.address"
            placeholder="Địa chỉ (ví dụ: 103 Vạn Phúc, phường Vạn Phúc)" autocomplete="off" class="form-control" />
        </div>
      </div>
    </div>
    <div class="grid">
      <div class="grid-column four-twelfths mobile--one-whole">
        <div dir="auto" class="v-select vue-select vs--single vs--searchable" name="nhanh_city">
          <div @click="toggleCityDropdown" id="vs1-combobox" role="combobox" :aria-expanded="showCityDropdown"
            aria-owns="vs1-listbox" aria-label="Search for option" class="vs-dropdown-toggle">
            <div class="vs-selected-options">
              <span class="vs-selected"> {{ activeCity.name }}</span>
              <input aria-autocomplete="list" aria-labelledby="vs1-combobox" aria-controls="vs1-listbox" type="search"
                autocomplete="off" class="vs-search" readonly />
              <ul class="city-list" v-show="showCityDropdown" id="vs1-listbox" role="listbox" aria-label="cities">
                <li v-for="(city, index) in cities" class="city-option" role="option" :id="'city-' + index"
                  @mouseover="setActiveCity(index)">
                  {{ city.name }}
                </li>
              </ul>
            </div>

            <div class="vs-actions">
              <button type="button" title="Clear Selected" aria-label="Clear Selected" class="vs-clear"
                style="display: none">
                <svg xmlns="http://www.w3.org/2000/svg" width="10" height="10">
                  <path
                    d="M6.895455 5l2.842897-2.842898c.348864-.348863.348864-.914488 0-1.263636L9.106534.261648c-.348864-.348864-.914489-.348864-1.263636 0L5 3.104545 2.157102.261648c-.348863-.348864-.914488-.348864-1.263636 0L.261648.893466c-.348864.348864-.348864.914489 0 1.263636L3.104545 5 .261648 7.842898c-.348864.348863-.348864.914488 0 1.263636l.631818.631818c.348864.348864.914773.348864 1.263636 0L5 6.895455l2.842898 2.842897c.348863.348864.914772.348864 1.263636 0l.631818-.631818c.348864-.348864.348864-.914489 0-1.263636L6.895455 5z">
                  </path>
                </svg>
              </button>
              <svg xmlns="http://www.w3.org/2000/svg" width="14" height="10" role="presentation"
                class="vs-open-indicator">
                <path
                  d="M9.211364 7.59931l4.48338-4.867229c.407008-.441854.407008-1.158247 0-1.60046l-.73712-.80023c-.407008-.441854-1.066904-.441854-1.474243 0L7 5.198617 2.51662.33139c-.407008-.441853-1.066904-.441853-1.474243 0l-.737121.80023c-.407008.441854-.407008 1.158248 0 1.600461l4.48338 4.867228L7 10l2.211364-2.40069z">
                </path>
              </svg>
              <div class="vs-spinner" style="display: none">Loading...</div>
            </div>
          </div>
        </div>
      </div>
      <div class="grid-column four-twelfths mobile--one-whole">
        <div dir="auto" class="v-select vue-select vs--single vs--searchable" name="nhanh_district">
          <div @click="toggleDistrictDropdown" id="vs2-combobox" role="combobox" :aria-expanded="showDistrictDropdown"
            aria-owns="vs2-listbox" aria-label="Search for option" class="vs-dropdown-toggle">
            <div class="vs-selected-options">
              <span class="vs-selected"> {{ activeDistrict.name }}</span>
              <input aria-autocomplete="list" aria-labelledby="vs2-combobox" aria-controls="vs2-listbox" type="search"
                autocomplete="off" class="vs-search" readonly />
              <ul class="district-list" v-show="showDistrictDropdown" id="vs2-listbox" role="listbox"
                aria-label="districts">
                <li v-for="(district, index2) in districts" class="district-option" role="option"
                  :id="'district-' + index2" @mouseover="setActiveDistrict(index2)" :key="index2">
                  {{ district.name }}
                </li>
              </ul>
            </div>
            <div class="vs-actions">
              <button type="button" title="Clear Selected" aria-label="Clear Selected" class="vs-clear"
                style="display: none">
                <svg xmlns="http://www.w3.org/2000/svg" width="10" height="10">
                  <path
                    d="M6.895455 5l2.842897-2.842898c.348864-.348863.348864-.914488 0-1.263636L9.106534.261648c-.348864-.348864-.914489-.348864-1.263636 0L5 3.104545 2.157102.261648c-.348863-.348864-.914488-.348864-1.263636 0L.261648.893466c-.348864.348864-.348864.914489 0 1.263636L3.104545 5 .261648 7.842898c-.348864.348863-.348864.914488 0 1.263636l.631818.631818c.348864.348864.914773.348864 1.263636 0L5 6.895455l2.842898 2.842897c.348863.348864.914772.348864 1.263636 0l.631818-.631818c.348864-.348864.348864-.914489 0-1.263636L6.895455 5z">
                  </path>
                </svg>
              </button>
              <svg xmlns="http://www.w3.org/2000/svg" width="14" height="10" role="presentation"
                class="vs-open-indicator">
                <path
                  d="M9.211364 7.59931l4.48338-4.867229c.407008-.441854.407008-1.158247 0-1.60046l-.73712-.80023c-.407008-.441854-1.066904-.441854-1.474243 0L7 5.198617 2.51662.33139c-.407008-.441853-1.066904-.441853-1.474243 0l-.737121.80023c-.407008.441854-.407008 1.158248 0 1.600461l4.48338 4.867228L7 10l2.211364-2.40069z">
                </path>
              </svg>
              <div class="vs-spinner" style="display: none">Loading...</div>
            </div>
          </div>
        </div>
      </div>
      <div class="grid-column four-twelfths mobile--one-whole">
        <div dir="auto" class="v-select vue-select vs--single vs--searchable" name="nhanh_ward" id="nhanh_ward">
          <div @click="toggleVillageDropdown" id="vs3-combobox" role="combobox" :aria-expanded="showVillageDropdown"
            aria-owns="vs3-listbox" aria-label="Search for option" class="vs-dropdown-toggle">
            <div class="vs-selected-options">
              <span class="vs-selected"> {{ activeVillage.name }}</span>
              <input aria-autocomplete="list" aria-labelledby="vs3-combobox" aria-controls="vs3-listbox" type="search"
                autocomplete="off" class="vs-search" readonly />
              <ul class="village-list" v-show="showVillageDropdown" id="vs3-listbox" role="listbox"
                aria-label="villages">
                <li v-for="(village, index) in villages" class="village-option" role="option" :id="'village-' + index"
                  @mouseover="setActiveVillage(index)">
                  {{ village.name }}
                </li>
              </ul>
            </div>

            <div class="vs-actions">
              <button type="button" title="Clear Selected" aria-label="Clear Selected" class="vs-clear"
                style="display: none">
                <svg xmlns="http://www.w3.org/2000/svg" width="10" height="10">
                  <path
                    d="M6.895455 5l2.842897-2.842898c.348864-.348863.348864-.914488 0-1.263636L9.106534.261648c-.348864-.348864-.914489-.348864-1.263636 0L5 3.104545 2.157102.261648c-.348863-.348864-.914488-.348864-1.263636 0L.261648.893466c-.348864.348864-.348864.914489 0 1.263636L3.104545 5 .261648 7.842898c-.348864.348863-.348864.914488 0 1.263636l.631818.631818c.348864.348864.914773.348864 1.263636 0L5 6.895455l2.842898 2.842897c.348863.348864.914772.348864 1.263636 0l.631818-.631818c.348864-.348864.348864-.914489 0-1.263636L6.895455 5z">
                  </path>
                </svg>
              </button>
              <svg xmlns="http://www.w3.org/2000/svg" width="14" height="10" role="presentation"
                class="vs-open-indicator">
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
    <div class="grid">
      <div class="grid-column">
        <input type="text" name="cnote" placeholder="Ghi chú thêm (Ví dụ: Giao hàng giờ hành chính)"
          class="form-control" />
      </div>
    </div>
  </div>

  <!-- Modal -->
  <div class="modal fade" id="address-modal" tabindex="-1" aria-labelledby="exampleModalLabel" data-bs-backdrop="false"
    data-bs-focus="true" aria-hidden="false">
    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
      <div class="modal-content">
        <div class="modal-header" style="z-index:1">
          <div class="modal-title h3" id="exampleModalLabel">Chọn địa chỉ</div>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body" style="z-index:2">
          <div class="grid">
            <form style="width: 100%;">
              <div v-for="(address, index) in addresses" v-if="!isLoading" style=" margin-bottom: 0.75rem">
                <label class="address-item custom-cursor-on-hover"
                  :class="{ 'active': addressFromAddressBook.id == address.id }">
                  <span class="address-item-custom-checkbox custom-radio"><input type="radio" autocomplete="off"
                      :value="index" @click="choseAddressOption" />
                    <span class="address-checkmark"
                      :style="{ 'display': addressFromAddressBook.id == address.id ? 'block' : 'none' }"></span>
                  </span>
                  <div class="address-item-content">
                    <div class="d-flex">
                      <span>{{ address.belongsTo }}</span>
                      <span class="default-tag" v-if="address.isDefault">Mặc định</span> <br />
                    </div>
                    {{ address.phone }} <br />
                    {{ address.displayingAddress }}
                  </div>
                </label>
              </div>
            </form>
          </div>
        </div>
        <div class="modal-footer" style="z-index:1">
          <!-- <button type="button" class="btn-save btn" data-bs-dismiss="modal" @click="">Lưu thay đổi</button> -->
          <button type="button" class="btn btn-cancel" data-bs-dismiss="modal">Trở lại</button>
          <!-- <button type="button" class="btn btn-primary btn-save">Lưu</button> -->
        </div>
      </div>
    </div>
  </div>

</template>

<style scoped>
.title-with-actions {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin: 2rem 0 1rem;
}

.title-with-actions .title {
  margin: 0;
}

.title {
  font-size: 30px;
  font-weight: 700;
  margin: 2rem 0 1rem;
}

.title-with-actions .action a {
  color: #2f5acf;
}

a:hover {
  text-decoration: underline;
  color: #2f5acf;
}

.cart-left-section .address_book_icon {
  display: inline-block;
  margin-right: 3px;
  width: 20px;
  height: 20px;
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

.four-twelfths {
  width: 33.333%;
}

.grid-column {
  position: relative;
  box-sizing: border-box;
  min-height: 1px;
  vertical-align: top;
  margin-left: 0 !important;
  margin-right: 0 !important;
  padding: 9px;
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

.four-twelfths {
  width: 33.333%;
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
  max-height: 200px;
  cursor: pointer;
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

.title {
  font-size: 30px;
  font-weight: 700;
  margin: 2rem 0 1rem;
}

.address-item {
  display: flex;
  align-items: center;
  border: 1px solid #d9d9d9;
  border-radius: 16px;
  padding: 15px 20px;
  cursor: pointer;
  transition: 0.2s all;
  opacity: 0.6;
}

.address-item.active,
.address-item:not(.disabled):hover {
  border: 1px solid #2f5acf;
  opacity: 1;
}

.custom-checkbox,
.custom-radio {
  display: block;
  position: relative;
  flex: 0 0 20px;
  width: 20px;
  height: 20px;
  border: 1px solid #d9d9d9;
  border-radius: 20px;
  transition: all 0.2s;
}

.custom-checkbox input,
.custom-radio input {
  display: none;
}

.custom-checkbox .address-checkmark,
.custom-radio .address-checkmark {
  display: none;
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  width: 10px;
  height: 10px;
  border-radius: 20px;
  background-color: #2f5acf;
}

.address-item-icon-wrapper {
  margin: 0 1.5rem;
}

.address-item-icon-wrapper img {
  min-width: 35px;
  max-height: 35px;
  max-width: 55px;
}

.address-item.active .address-item-custom-checkbox,
.address-item:not(.disabled):hover .address-item-custom-checkbox {
  border: 1px solid #2f5acf;
}

a {
  background-color: transparent;
  text-decoration: none;
  color: inherit;
  transition: all 0.2s;
}

button,
input {
  overflow: visible;
}

button,
input,
optgroup,
select,
textarea {
  font-family: inherit;
  font-size: 100%;
  line-height: 1.15;
  margin: 0;
  -webkit-box-shadow: inset 0 0 0 9999px transparent;
  -webkit-appearance: none;
  -moz-appearance: none;
  appearance: none;
  box-shadow: none;
  border-radius: 0;
}

.checkout-btn {
  border-radius: 16px;
  height: 55px;
  width: 100%;
  padding: 15px 20px;
  background-color: #000;
  color: #fff;
  text-align: center;
  border: none;
  cursor: pointer;
  transition: all 0.2s;
}

.checkout-btn:hover {
  background-color: #d9d9d9;
  color: #000;
}

.address-item-content {
  margin: 0px 15px;
}

.modal {
  overflow: visible;
  --bs-modal-width: 700px;
}

.modal-header {
  padding: 9px;
  padding-left: 20px;
}

.modal-body {
  padding: 15px 25px;
  overflow-y: scroll;
}

.modal-content {
  overflow: visible;
}

.default-tag {
  display: flex;
  justify-content: center;
  align-items: center;
  border: 1px solid rgba(0, 0, 0, .1333333333);
  border-radius: 100vmax;
  padding: 4px 10px 5px;
  font-size: .75rem;
  margin-left: 0.5rem;
  min-width: 50px;
}

.default-tag:before {
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
</style>
