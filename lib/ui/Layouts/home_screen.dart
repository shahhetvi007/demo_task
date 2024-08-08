import 'package:demo_task/bloc/base/base_bloc.dart';
import 'package:demo_task/bloc/main/main_bloc.dart';
import 'package:demo_task/models/current_bookings.dart';
import 'package:demo_task/models/packages.dart';
import 'package:demo_task/ui/Layouts/base_screen.dart';
import 'package:demo_task/ui/res/color_resources.dart';
import 'package:demo_task/ui/res/image_resources.dart';
import 'package:demo_task/ui/widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends BaseStatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseState<HomeScreen>
    with BasicScreen, WidgetsBindingObserver {
  late MainBloc mainBloc;

  List<BookingsResponse>? bookingResponse;
  List<PackagesResponse>? packagesResponse;

  final _advancedDrawerController = AdvancedDrawerController();

  @override
  void initState() {
    super.initState();
    mainBloc = MainBloc(BaseBloc());
    getAllCurrentBookings();
    getAllPackages();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MainBloc, MainStates>(
      bloc: mainBloc,
      listener: (ctx, state) {
        print(state is GetPackagesResponseState);
        if (state is GetPackagesResponseState) {
          print("GetPackagesResponseState");
          _onGetAllPackagesSuccess(state.response);
        } else if (state is GetBookingsResponseState) {
          print("GetBookingsResponseState");
          _onGetAllBookingsSuccess(state.response);
        }
      },
      child: super.build(context),
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return AdvancedDrawer(
      backdrop: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
      ),
      childDecoration: const BoxDecoration(
          // NOTICE: Uncomment if you want to add shadow behind the page.
          // Keep in mind that it may cause animation jerks.
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
            ),
          ], borderRadius: BorderRadius.all(Radius.circular(16))),
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      openRatio: 0.6,
      openScale: 0.9,
      drawer: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: ListTileTheme(
            textColor: colorFont,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 100.0,
                  height: 100.0,
                  margin: const EdgeInsets.only(
                    top: 24.0,
                  ),
                  child: Image.asset(
                    AppImage.profileImage,
                    width: 72,
                    height: 72,
                  ),
                ),
                getSmallText(
                  'Emily Cyrus',
                  fontSize: 20,
                  weight: FontWeight.w700,
                ),
                const SizedBox(height: 32),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  child: getSmallText(
                    "Home",
                    color: colorAccent,
                    fontSize: 18,
                    weight: FontWeight.w500,
                  ),
                ),
                const Divider(color: colorPrimaryLight),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  child: getSmallText(
                    "Book A Nanny",
                    color: colorAccent,
                    fontSize: 18,
                    weight: FontWeight.w500,
                  ),
                ),
                const Divider(color: colorPrimaryLight),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  child: getSmallText(
                    "How It Works",
                    color: colorAccent,
                    fontSize: 18,
                    weight: FontWeight.w500,
                  ),
                ),
                const Divider(color: colorPrimaryLight),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  child: getSmallText(
                    "Why Nanny Vanny",
                    color: colorAccent,
                    fontSize: 18,
                    weight: FontWeight.w500,
                  ),
                ),
                const Divider(color: colorPrimaryLight),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  child: getSmallText(
                    "My Bookings",
                    color: colorAccent,
                    fontSize: 18,
                    weight: FontWeight.w500,
                  ),
                ),
                const Divider(color: colorPrimaryLight),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  child: getSmallText(
                    "My Profile",
                    color: colorAccent,
                    fontSize: 18,
                    weight: FontWeight.w500,
                  ),
                ),
                const Divider(color: colorPrimaryLight),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  child: getSmallText(
                    "Support",
                    color: colorAccent,
                    fontSize: 18,
                    weight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      child: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Scaffold(
            backgroundColor: colorWhite,
            bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: colorPrimary,
              unselectedItemColor: colorFont,
              unselectedLabelStyle: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: colorFont,
              ),
              items: [
                BottomNavigationBarItem(
                    icon: Image.asset(AppImage.homeIcon), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Image.asset(AppImage.saleIcon), label: 'Packages'),
                BottomNavigationBarItem(
                    icon: Image.asset(AppImage.clockIcon), label: 'Bookings'),
                BottomNavigationBarItem(
                    icon: Image.asset(AppImage.userIcon), label: 'Profile'),
              ],
            ),
            body: packagesResponse != null && bookingResponse != null
                ? SingleChildScrollView(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 24),
                          GestureDetector(
                            onTap: () {
                              openDrawer();
                            },
                            child: Container(
                              alignment: Alignment.centerRight,
                              child: Image.asset(AppImage.menuIcon),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Image.asset(
                                AppImage.profileImage,
                                height: 50,
                                width: 50,
                              ),
                              const SizedBox(width: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  getSmallText(
                                    'Welcome',
                                    weight: FontWeight.w700,
                                    fontSize: 16,
                                    color: colorFont,
                                  ),
                                  getSmallText(
                                    'Emily Cyrus',
                                    weight: FontWeight.w700,
                                    fontSize: 20,
                                    color: colorPrimary,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Stack(
                            children: [
                              Container(
                                width: double.infinity,
                                height: 154,
                                margin: const EdgeInsets.only(top: 32),
                                decoration: BoxDecoration(
                                  color: colorPrimaryLight,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              Image.asset(AppImage.homeImage),
                              Container(
                                height: 154,
                                margin: const EdgeInsets.only(top: 32),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                width: 180,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    getSmallText(
                                      "Nanny And Babysitting Services",
                                      fontSize: 18,
                                      weight: FontWeight.w700,
                                      color: colorAccent,
                                      lines: 3,
                                    ),
                                    const SizedBox(height: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4, horizontal: 12),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        color: colorAccent,
                                      ),
                                      child: getSmallText(
                                        'Book Now',
                                        weight: FontWeight.w500,
                                        fontSize: 12,
                                        color: colorWhite,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          getSmallText(
                            'Your Current Booking',
                            weight: FontWeight.w700,
                            fontSize: 20,
                            color: colorAccent,
                          ),
                          const SizedBox(height: 8),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: bookingResponse!.length,
                            itemBuilder: (ctx, i) =>
                                currentBookingCard(bookingResponse![i]),
                          ),
                          const SizedBox(height: 24),
                          getSmallText(
                            'Packages',
                            weight: FontWeight.w700,
                            fontSize: 20,
                            color: colorAccent,
                          ),
                          const SizedBox(height: 8),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: packagesResponse!.length,
                            itemBuilder: (ctx, i) =>
                                packageCard(packagesResponse![i], i + 1),
                          ),
                        ],
                      ),
                    ),
                  )
                : const Center(
                    child: CircularProgressIndicator(
                      color: colorPrimary,
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Widget currentBookingCard(BookingsResponse currentBooking) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                getSmallText(
                  currentBooking.title,
                  weight: FontWeight.w500,
                  fontSize: 16,
                  color: colorPrimary,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: colorPrimary,
                  ),
                  child: getSmallText(
                    'Start',
                    weight: FontWeight.w500,
                    fontSize: 11,
                    color: colorWhite,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getSmallText(
                      'From',
                      weight: FontWeight.w400,
                      fontSize: 12,
                      color: colorFont,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_month_rounded,
                          color: colorPrimary,
                          size: 9,
                        ),
                        const SizedBox(width: 8),
                        getSmallText(
                          currentBooking.fromDate,
                          weight: FontWeight.w500,
                          fontSize: 16,
                          color: colorFont,
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(
                          Icons.access_time_outlined,
                          color: colorPrimary,
                          size: 9,
                        ),
                        const SizedBox(width: 8),
                        getSmallText(
                          currentBooking.fromTime,
                          weight: FontWeight.w500,
                          fontSize: 16,
                          color: colorFont,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(width: 32),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getSmallText(
                      'To',
                      weight: FontWeight.w400,
                      fontSize: 12,
                      color: colorFont,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_month_rounded,
                          color: colorPrimary,
                          size: 9,
                        ),
                        const SizedBox(width: 8),
                        getSmallText(
                          currentBooking.toDate,
                          weight: FontWeight.w500,
                          fontSize: 16,
                          color: colorFont,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.access_time_outlined,
                          color: colorPrimary,
                          size: 9,
                        ),
                        const SizedBox(width: 8),
                        getSmallText(
                          currentBooking.toTime,
                          weight: FontWeight.w500,
                          fontSize: 16,
                          color: colorFont,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: colorAccent,
                  ),
                  child: Row(
                    children: [
                      Image.asset(AppImage.star),
                      const SizedBox(width: 4),
                      getSmallText(
                        'Rate us',
                        weight: FontWeight.w500,
                        fontSize: 11,
                        color: colorWhite,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: colorAccent,
                  ),
                  child: Row(
                    children: [
                      Image.asset(AppImage.pin),
                      const SizedBox(width: 4),
                      getSmallText(
                        'Geolocation',
                        weight: FontWeight.w500,
                        fontSize: 11,
                        color: colorWhite,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: colorAccent,
                  ),
                  child: Row(
                    children: [
                      Image.asset(AppImage.radio),
                      const SizedBox(width: 4),
                      getSmallText(
                        'Survillence',
                        weight: FontWeight.w500,
                        fontSize: 11,
                        color: colorWhite,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget packageCard(PackagesResponse currentPackage, int index) {
    bool isEven = index % 2 == 0;
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: isEven ? colorBlue : colorPrimaryLight,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (currentPackage.title.contains("One"))
                Image.asset(AppImage.calendar01),
              if (currentPackage.title.contains("Three"))
                Image.asset(AppImage.calendar03),
              if (currentPackage.title.contains("Five"))
                Image.asset(AppImage.calendar05),
              if (currentPackage.title.contains("Weekend"))
                Image.asset(AppImage.calSunset),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: isEven ? colorBlue1 : colorPrimary,
                ),
                child: getSmallText(
                  'Book Now',
                  weight: FontWeight.w500,
                  fontSize: 12,
                  color: colorWhite,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              getSmallText(
                currentPackage.title,
                weight: FontWeight.w500,
                fontSize: 16,
                color: colorAccent,
              ),
              getSmallText(
                '₹${currentPackage.price}',
                weight: FontWeight.w700,
                fontSize: 16,
                color: colorAccent,
              ),
            ],
          ),
          const SizedBox(height: 12),
          getSmallText(
            currentPackage.desc,
            weight: FontWeight.w400,
            fontSize: 10,
            color: colorFont,
            lines: 5,
          ),
        ],
      ),
    );
  }

  void getAllCurrentBookings() {
    mainBloc.add(GetBookingsEvent());
  }

  void _onGetAllBookingsSuccess(CurrentBookings response) {
    if (response.code == "200") {
      bookingResponse = response.response;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: getSmallText(response.message,
              fontSize: 12, color: colorAccent)));
    }
    setState(() {});
  }

  void getAllPackages() {
    mainBloc.add(GetPackagesEvent());
  }

  void _onGetAllPackagesSuccess(PackagesList response) {
    print("All packages success");
    print(response.code);
    if (response.code == "200") {
      packagesResponse = response.response;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: getSmallText(response.message,
              fontSize: 12, color: colorAccent)));
    }
    setState(() {});
  }

  void openDrawer() {
    _advancedDrawerController.showDrawer();
  }
}
