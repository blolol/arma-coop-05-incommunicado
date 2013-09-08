/**
 * Ambient civilian vehicle spawn configuration.
**/

class AmbientCivilianVehicles {
	class Locations {
		class NameLocal {
			minMaxVehicles[] = { 0, 1 };
		};

		class NameVillage {
			minMaxVehicles[] = { 0, 2 };
		};

		class NameCity {
			minMaxVehicles[] = { 0, 5 };
		};

		class NameCityCapital {
			minMaxVehicles[] = { 0, 8 };
		};
	};

	class Vehicles {
		class C_Hatchback_01_F {
			weight = 0.5;
		};

		class C_Hatchback_01_sport_F {
			weight = 0.1;
		};

		class C_Offroad_01_F {
			weight = 0.95;
		};

		class C_Quadbike_01_F {
			weight = 0.85;
		};

		class C_SUV_01_F {
			weight = 0.2;
		};

		class C_Van_01_transport_F {
			weight = 0.4;
		};

		class C_Van_01_box_F {
			weight = 0.4;
		};
	};
};
