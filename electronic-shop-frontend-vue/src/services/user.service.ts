import type { Review } from '@/components/profile/account-content/OrderCard.vue';
import axios from 'axios';

export type Address = {
    id?: string,
    belongsTo: string,
    phone: string,
    address: string,
    cityId: string,
    districtId: string,
    wardId: string,
    customer: User,
    isDefault: boolean,
    displayingAddress?: string
}

export type User = {
    id: number,
    account: string,
    password: string,
    name: string,
    phone: string,
    email: string,
    avatar: string,
    dob: Date,
    roles: any,
    locked: boolean
}

export class UserService {
   
    constructor() {
    }

    public async postAddress(address: Address) {
        const baseUri = this.getBaseUri();
        return await axios.post(`${baseUri}`, address);
    }

    public async getAddressesByCustomerId(customerId) {
        const baseUri = this.getBaseUri();
        return (await axios.get(`${baseUri}/customer/${customerId}`));
    }

    
    public async getDefaultAddressOfCustomer(customerId) {
        const baseUri = this.getBaseUri();
        return (await axios.get(`${baseUri}/customer/${customerId}/default`));
    }

    public async updateAddress(id, address: Address) {
        const baseUri = this.getBaseUri();
        return await axios.put(`${baseUri}/customer/${id}`, address);
    }

    public async deleteAddress(id) {
        const baseUri = this.getBaseUri();
        return await axios.delete(`${baseUri}/${id}`);
    }

    async getCity() {

        const baseUri = this.getGHNUri();
        return (await axios.get(`${baseUri}/master-data/province`, {
            headers: {
                "Content-Type": "application/json",
                "Token": "726cd839-e9d8-11ee-b1d4-92b443b7a897",
                "ShopId": "191483"
            }
        }));

    }

    async getCityById(cityId: string) {

        const baseUri = this.getGHNUri();
        const cities = (await axios.get(`${baseUri}/master-data/province`, {
            headers: {
                "Content-Type": "application/json",
                "Token": "726cd839-e9d8-11ee-b1d4-92b443b7a897",
                "ShopId": "191483"
            }
        }));

        return cities.data.data.find(x => x.ProvinceID.toString() === cityId);

    }

    async getDistrict(cityId: string) {

        const baseUri = this.getGHNUri();
        return (await axios.get(`${baseUri}/master-data/district`, {
            headers: {
                "Content-Type": "application/json",
                "Token": "726cd839-e9d8-11ee-b1d4-92b443b7a897",
                "ShopId": "191483"
            },
            params: {
                "province_id": cityId,
            }
        }));

    }

    async getDistrictById(cityId: string, districtId: string) {

        const baseUri = this.getGHNUri();
        const districts = (await axios.get(`${baseUri}/master-data/district`, {
            headers: {
                "Content-Type": "application/json",
                "Token": "726cd839-e9d8-11ee-b1d4-92b443b7a897",
                "ShopId": "191483"
            },
            params: {
                "province_id": cityId,
            }
        }));

        return districts.data.data.find(x => x.DistrictID.toString() === districtId.toString());
    }

    async getWard(districtId: string) {
        const baseUri = this.getGHNUri();
        return (await axios.get(`${baseUri}/master-data/ward`, {
            headers: {
                "Content-Type": "application/json",
                "Token": "726cd839-e9d8-11ee-b1d4-92b443b7a897",
                "ShopId": "191483"
            },
            params: {
                "district_id": districtId,
            }
        }));

    }

    async getWardById(districtId: string, wardId: string) {
        const baseUri = this.getGHNUri();
        const wards = (await axios.get(`${baseUri}/master-data/ward`, {
            headers: {
                "Content-Type": "application/json",
                "Token": "726cd839-e9d8-11ee-b1d4-92b443b7a897",
                "ShopId": "191483"
            },
            params: {
                "district_id": districtId,
            }
        }));

        return wards.data.data.find(x => x.WardCode.toString() === wardId.toString());
    }

    getBaseUri() {
        return `${import.meta.env.VITE_BACKEND_BASE_URL}/addresses`;
    }

    getGHNUri() {
        return `https://dev-online-gateway.ghn.vn/shiip/public-api`;
    }

}

const userService = new UserService();
export const provideUserService = () => {
    return {
        userService,
    };
};