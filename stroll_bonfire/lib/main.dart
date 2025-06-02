import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
  
  runApp(const StrollBonfireApp());
}

class StrollBonfireApp extends StatelessWidget {
  const StrollBonfireApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return BlocProvider(
          create: (context) => StrollCubit()..initialize(),
          child: MaterialApp(
            title: 'Stroll Bonfire',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: '.SF Pro Display',
              useMaterial3: false,
            ),
            home: const StrollBonfirePage(),
          ),
        );
      },
    );
  }
}

// EXACT COLOR MATCHING FROM DESIGN
class AppColors {
  static const Color white = Color(0xFFFFFFFF);
  static const Color white90 = Color(0xE6FFFFFF);
  static const Color white70 = Color(0xB3FFFFFF);
  static const Color white60 = Color(0x99FFFFFF);
  static const Color white40 = Color(0x66FFFFFF);
  static const Color white20 = Color(0x33FFFFFF);
  static const Color white15 = Color(0x26FFFFFF);
  static const Color white10 = Color(0x1AFFFFFF);
  
  // Exact gradient from design
  static const List<Color> backgroundGradient = [
    Color(0xFF8B9DC3), // Top blue
    Color(0xFF8B9DC3), // Blue
    Color(0xFFDDB892), // Peach/orange
    Color(0xFFDDB892), // Orange
    Color(0xFFFFC397), // Light orange
    Color(0xFFDDB892), // Bottom orange
  ];
  
  // Option background colors (matching design)
  static const Color morningBg = Color(0x4DFF6B35);     // Orange with opacity
  static const Color goldenBg = Color(0x4DFFB347);      // Amber with opacity  
  static const Color dinnerBg = Color(0x4D4FC3F7);      // Blue with opacity
  static const Color midnightBg = Color(0x4D9C27B0);    // Purple with opacity
  
  // Action button colors
  static const Color rejectRed = Color(0xFFE94057);
  static const Color micBlue = Color(0xFF8A2BE2);
  static const Color acceptGreen = Color(0xFF61C3F2);
  
  // Status indicator
  static const Color onlineGreen = Color(0xFF4CAF50);
}

// RESPONSIVE UTILITIES
class ResponsiveUtils {
  static double width(double size) => size.w;
  static double height(double size) => size.h;
  static double fontSize(double size) => size.sp;
  static double radius(double size) => size.r;
  
  static EdgeInsets padding({
    double? all,
    double? horizontal,
    double? vertical,
    double? top,
    double? bottom,
    double? left,
    double? right,
  }) {
    if (all != null) return EdgeInsets.all(all.w);
    return EdgeInsets.only(
      top: (top ?? vertical ?? 0).h,
      bottom: (bottom ?? vertical ?? 0).h,
      left: (left ?? horizontal ?? 0).w,
      right: (right ?? horizontal ?? 0).w,
    );
  }
}

// CUBIT STATE MANAGEMENT
class StrollState {
  final int selectedOptionIndex;
  final bool isLoading;
  
  const StrollState({
    this.selectedOptionIndex = -1,
    this.isLoading = false,
  });
  
  StrollState copyWith({
    int? selectedOptionIndex,
    bool? isLoading,
  }) {
    return StrollState(
      selectedOptionIndex: selectedOptionIndex ?? this.selectedOptionIndex,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class StrollCubit extends Cubit<StrollState> {
  StrollCubit() : super(const StrollState());
  
  void initialize() {
    // Initialize with default state
  }
  
  void selectOption(int index) {
    emit(state.copyWith(selectedOptionIndex: index));
  }
  
  void skipUser() {
    emit(state.copyWith(selectedOptionIndex: -1));
  }
  
  void likeUser() {
    if (state.selectedOptionIndex != -1) {
      // Handle like action
      emit(state.copyWith(selectedOptionIndex: -1));
    }
  }
  
  void startVoiceMessage() {
    // Handle voice message
  }
}

// MAIN PAGE WIDGET
class StrollBonfirePage extends StatelessWidget {
  const StrollBonfirePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: AppColors.backgroundGradient,
            stops: [0.0, 0.2, 0.4, 0.6, 0.8, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const StrollHeader(),
              Expanded(
                child: Padding(
                  padding: ResponsiveUtils.padding(horizontal: 20),
                  child: Column(
                    children: [
                      SizedBox(height: ResponsiveUtils.height(20)),
                      const ProfileCard(),
                      SizedBox(height: ResponsiveUtils.height(32)),
                      const OptionsSection(),
                      const Spacer(),
                      const ActionButtons(),
                      SizedBox(height: ResponsiveUtils.height(20)),
                    ],
                  ),
                ),
              ),
              const BottomNavigation(),
            ],
          ),
        ),
      ),
    );
  }
}

// HEADER COMPONENT
class StrollHeader extends StatelessWidget {
  const StrollHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: ResponsiveUtils.padding(all: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Stroll Bonfire',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: ResponsiveUtils.fontSize(34),
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                color: AppColors.white70,
                size: ResponsiveUtils.width(16),
              ),
              SizedBox(width: ResponsiveUtils.width(4)),
              Text(
                '2 km',
                style: TextStyle(
                  color: AppColors.white70,
                  fontSize: ResponsiveUtils.fontSize(16),
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(width: ResponsiveUtils.width(16)),
              Icon(
                Icons.people_outline,
                color: AppColors.white70,
                size: ResponsiveUtils.width(16),
              ),
              SizedBox(width: ResponsiveUtils.width(4)),
              Text(
                '103',
                style: TextStyle(
                  color: AppColors.white70,
                  fontSize: ResponsiveUtils.fontSize(16),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// PROFILE CARD COMPONENT
class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: ResponsiveUtils.padding(all: 20),
      decoration: BoxDecoration(
        color: AppColors.white15,
        borderRadius: BorderRadius.circular(ResponsiveUtils.radius(20)),
        border: Border.all(
          color: AppColors.white20,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Stack(
            children: [
              Container(
                width: ResponsiveUtils.width(64),
                height: ResponsiveUtils.width(64),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.onlineGreen,
                    width: 3,
                  ),
                ),
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=150&fit=crop&crop=face',
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: AppColors.white20,
                      child: Icon(
                        Icons.person,
                        color: AppColors.white40,
                        size: ResponsiveUtils.width(32),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: AppColors.white20,
                      child: Icon(
                        Icons.person,
                        color: AppColors.white40,
                        size: ResponsiveUtils.width(32),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 2,
                right: 2,
                child: Container(
                  width: ResponsiveUtils.width(12),
                  height: ResponsiveUtils.width(12),
                  decoration: const BoxDecoration(
                    color: AppColors.onlineGreen,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: ResponsiveUtils.width(16)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Angelko, 28',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: ResponsiveUtils.fontSize(18),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: ResponsiveUtils.height(8)),
                Text(
                  'What is your favorite time of the day?',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: ResponsiveUtils.fontSize(20),
                    fontWeight: FontWeight.w500,
                    height: 1.2,
                  ),
                ),
                SizedBox(height: ResponsiveUtils.height(6)),
                Text(
                  '"Mine is definitely in the morning"',
                  style: TextStyle(
                    color: AppColors.white70,
                    fontSize: ResponsiveUtils.fontSize(14),
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// OPTIONS SECTION
class OptionsSection extends StatelessWidget {
  const OptionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pick your option.\nSee who has a similar mind.',
          style: TextStyle(
            color: AppColors.white,
            fontSize: ResponsiveUtils.fontSize(16),
            fontWeight: FontWeight.w500,
            height: 1.3,
          ),
        ),
        SizedBox(height: ResponsiveUtils.height(24)),
        BlocBuilder<StrollCubit, StrollState>(
          builder: (context, state) {
            final options = [
              {
                'icon': Icons.wb_sunny_outlined,
                'text': 'The peace in the\nearly mornings',
                'color': AppColors.morningBg,
              },
              {
                'icon': Icons.wb_twilight_outlined,
                'text': 'The magical\ngolden hours',
                'color': AppColors.goldenBg,
              },
              {
                'icon': Icons.restaurant_outlined,
                'text': 'Wind down time\nafter dinners',
                'color': AppColors.dinnerBg,
              },
              {
                'icon': Icons.nightlight_round_outlined,
                'text': 'The serenity past\nmidnight',
                'color': AppColors.midnightBg,
              },
            ];

            return Column(
              children: options.asMap().entries.map((entry) {
                final index = entry.key;
                final option = entry.value;
                final isSelected = state.selectedOptionIndex == index;
                
                return Padding(
                  padding: ResponsiveUtils.padding(bottom: 12),
                  child: OptionCard(
                    icon: option['icon'] as IconData,
                    text: option['text'] as String,
                    backgroundColor: option['color'] as Color,
                    isSelected: isSelected,
                    onTap: () => context.read<StrollCubit>().selectOption(index),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }
}

// OPTION CARD COMPONENT
class OptionCard extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color backgroundColor;
  final bool isSelected;
  final VoidCallback onTap;

  const OptionCard({
    super.key,
    required this.icon,
    required this.text,
    required this.backgroundColor,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: ResponsiveUtils.padding(all: 16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.white20 : AppColors.white10,
          borderRadius: BorderRadius.circular(ResponsiveUtils.radius(16)),
          border: Border.all(
            color: isSelected ? AppColors.white40 : AppColors.white20,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: ResponsiveUtils.padding(all: 10),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(ResponsiveUtils.radius(10)),
              ),
              child: Icon(
                icon,
                color: AppColors.white,
                size: ResponsiveUtils.width(20),
              ),
            ),
            SizedBox(width: ResponsiveUtils.width(14)),
            Text(
              text,
              style: TextStyle(
                color: AppColors.white,
                fontSize: ResponsiveUtils.fontSize(16),
                fontWeight: FontWeight.w500,
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ACTION BUTTONS
class ActionButtons extends StatelessWidget {
  const ActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StrollCubit, StrollState>(
      builder: (context, state) {
        return Row(
          children: [
            ActionButton(
              icon: Icons.close,
              color: AppColors.rejectRed,
              onTap: () => context.read<StrollCubit>().skipUser(),
            ),
            const Spacer(),
            ActionButton(
              icon: Icons.mic,
              color: AppColors.micBlue,
              onTap: () => context.read<StrollCubit>().startVoiceMessage(),
            ),
            SizedBox(width: ResponsiveUtils.width(16)),
            ActionButton(
              icon: Icons.arrow_forward,
              color: AppColors.acceptGreen,
              onTap: state.selectedOptionIndex != -1 
                  ? () => context.read<StrollCubit>().likeUser()
                  : null,
              isEnabled: state.selectedOptionIndex != -1,
            ),
          ],
        );
      },
    );
  }
}

// ACTION BUTTON COMPONENT
class ActionButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;
  final bool isEnabled;

  const ActionButton({
    super.key,
    required this.icon,
    required this.color,
    this.onTap,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isEnabled ? onTap : null,
      child: Container(
        width: ResponsiveUtils.width(64),
        height: ResponsiveUtils.width(64),
        decoration: BoxDecoration(
          color: isEnabled ? color : color.withValues(alpha: 0.5),
          shape: BoxShape.circle,
          boxShadow: isEnabled ? [
            BoxShadow(
              color: color.withValues(alpha: 0.3),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ] : null,
        ),
        child: Icon(
          icon,
          color: AppColors.white,
          size: ResponsiveUtils.width(28),
        ),
      ),
    );
  }
}

// BOTTOM NAVIGATION
class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: ResponsiveUtils.padding(
        horizontal: 40,
        vertical: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          NavIcon(Icons.home_outlined, false),
          NavIcon(Icons.explore_outlined, false),
          NavIcon(Icons.local_fire_department, true),
          NavIcon(Icons.chat_bubble_outline, false),
          NavIcon(Icons.person_outline, false),
        ],
      ),
    );
  }
}

// NAVIGATION ICON
class NavIcon extends StatelessWidget {
  final IconData icon;
  final bool isActive;

  const NavIcon(this.icon, this.isActive, {super.key});

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      color: isActive ? AppColors.white : AppColors.white60,
      size: ResponsiveUtils.width(28),
    );
  }
}