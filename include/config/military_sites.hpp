/**
 * Ambient military site configuration.
**/

class MilitarySites {
	class Locations {
		class MilitarySite1 {
			center = "mil_site_0";
			prizePositions[] = { "mil_site_0_prize_0" };

			class Groups {
				class CentralHQ {
					minMaxFill[] = { 0.5, 1.0 };
					positions[] = {
						{ 12848.2, 16674.5, 3.01267, 128.132 },
						{ 12850, 16681, 3.2895, 70.2339 },
						{ 12837.3, 16677.4, 3.14324, 225.037 },
						{ 12841.4, 16684.1, 2.90961, 0.573272 }
					};
				};

				class NorthObservationPost {
					minMaxFill[] = { 0.5, 1.0 };
					positions[] = {
						{ 12921.5, 16768.5, 4.27454, 56.702 },
						{ 12919.2, 16770.9, 4.33698, 48.6641 }
					};
				};

				class EastObservationPost {
					minMaxFill[] = { 0.5, 1.0 };
					positions[] = {
						{ 12903.8, 16680.3, 4.33312, 82.9786 },
						{ 12903.4, 16683.4, 4.24243, 81.2977 }
					};
				};

				class WestObservationPost {
					minMaxFill[] = { 0.5, 1.0 };
					positions[] = {
						{ 12800.8, 16738.1, 4.27618, 305.756 },
						{ 12799.3, 16735.6, 4.39983, 301.708 }
					};
				};
			}; // Groups
		}; // MilitarySite1
	}; // Locations

	class Prizes {
		class B_APC_Wheeled_01_cannon_F {
			weight = 0.15;
		};

		class B_APC_Tracked_01_rcws_F {
			weight = 0.10;
		};

		class B_G_Offroad_01_armed_F {
			weight = 1.00;
		};

		class B_MRAP_01_F {
			weight = 0.25;
		};

		class B_MRAP_01_gmg_F {
			weight = 0.10;
		};

		class B_MRAP_01_hmg_F {
			weight = 0.10;
		};
	}; // Prizes
};
