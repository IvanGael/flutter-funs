import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_explosive_like/all_device_infos_screen.dart';
import 'package:flutter_explosive_like/analytics_chart_screen.dart';
import 'package:flutter_explosive_like/animated_background_screen.dart';
import 'package:flutter_explosive_like/animated_bottom_sheet.dart';
import 'package:flutter_explosive_like/animated_parallax_bottomsheet_screen.dart';
import 'package:flutter_explosive_like/appoint_management_screen.dart';
import 'package:flutter_explosive_like/arc_loading.dart';
import 'package:flutter_explosive_like/automotive_screen.dart';
import 'package:flutter_explosive_like/background_generator.dart';
import 'package:flutter_explosive_like/ball_collector_game.dart';
import 'package:flutter_explosive_like/balloon_animation.dart';
import 'package:flutter_explosive_like/billing_screen.dart';
import 'package:flutter_explosive_like/bk_pos_terminal_screen.dart';
import 'package:flutter_explosive_like/atm_screen.dart';
import 'package:flutter_explosive_like/blinking_text_animation.dart';
import 'package:flutter_explosive_like/bloc/fleet_bloc.dart';
import 'package:flutter_explosive_like/bloc/fleet_tracking_screen.dart';
import 'package:flutter_explosive_like/bloc/notepad_screen.dart';
import 'package:flutter_explosive_like/bloc/signin_signup_screen.dart';
import 'package:flutter_explosive_like/blog_post_screen.dart';
import 'package:flutter_explosive_like/boarding_pass_screen.dart';
import 'package:flutter_explosive_like/boat_animation.dart';
import 'package:flutter_explosive_like/bookreader/book_reader_screen.dart';
import 'package:flutter_explosive_like/bot_chat_screen.dart';
import 'package:flutter_explosive_like/bouncing_spinner_loading.dart';
import 'package:flutter_explosive_like/camera_screen.dart';
import 'package:flutter_explosive_like/captif_portal_screen.dart';
import 'package:flutter_explosive_like/car_parking_simulate.dart';
import 'package:flutter_explosive_like/car_race.dart';
import 'package:flutter_explosive_like/car_rental_screen.dart';
import 'package:flutter_explosive_like/character_chatting_screen.dart';
import 'package:flutter_explosive_like/character_transformation_animation.dart';
import 'package:flutter_explosive_like/chat_animations.dart';
import 'package:flutter_explosive_like/chat_gpt_screen.dart';
import 'package:flutter_explosive_like/chat_screen.dart';
import 'package:flutter_explosive_like/chat_with_images_screen.dart';
import 'package:flutter_explosive_like/checkout_simulation.dart';
import 'package:flutter_explosive_like/chemical_elements_screen.dart';
import 'package:flutter_explosive_like/chess_game.dart';
import 'package:flutter_explosive_like/chess_game_screen.dart';
import 'package:flutter_explosive_like/cinema_screen.dart';
import 'package:flutter_explosive_like/cinema_ticket_booking_screen.dart';
import 'package:flutter_explosive_like/classroom_screen.dart';
import 'package:flutter_explosive_like/cli_screen.dart';
import 'package:flutter_explosive_like/color_changing_loader.dart';
import 'package:flutter_explosive_like/color_changing_text_animation.dart';
import 'package:flutter_explosive_like/color_extractor_screen.dart';
import 'package:flutter_explosive_like/color_matching_game.dart';
import 'package:flutter_explosive_like/coming_soon_screen.dart';
import 'package:flutter_explosive_like/container_rotation_screen.dart';
import 'package:flutter_explosive_like/countdown_card.dart';
import 'package:flutter_explosive_like/countdown_timer_screen.dart';
import 'package:flutter_explosive_like/country_grid_screen.dart';
import 'package:flutter_explosive_like/credit_card_screen.dart';
import 'package:flutter_explosive_like/crossword_game_screen.dart';
import 'package:flutter_explosive_like/crowdfunding_screen.dart';
import 'package:flutter_explosive_like/currency_converter_screen.dart';
import 'package:flutter_explosive_like/custom_3d_carousel.dart';
import 'package:flutter_explosive_like/custom_color_picker.dart';
import 'package:flutter_explosive_like/custom_notification_bell_animation_screen.dart';
import 'package:flutter_explosive_like/custom_richtext_editor_screen.dart';
import 'package:flutter_explosive_like/custom_top_navigation_bar.dart';
import 'package:flutter_explosive_like/customer_support.dart';
import 'package:flutter_explosive_like/deltalab_iot_screen.dart';
import 'package:flutter_explosive_like/dial_lock_screen.dart';
import 'package:flutter_explosive_like/dotted_loading.dart';
import 'package:flutter_explosive_like/edge_dinosaure_game_screen.dart';
import 'package:flutter_explosive_like/elevator_simulator_screen.dart';
import 'package:flutter_explosive_like/emergency_services_screen.dart';
import 'package:flutter_explosive_like/emotional_storytelling_animation.dart';
import 'package:flutter_explosive_like/endless_runner_game.dart';
import 'package:flutter_explosive_like/event_calendar_screen.dart';
import 'package:flutter_explosive_like/expanding_circle_loading.dart';
import 'package:flutter_explosive_like/expense_tracker_screen.dart';
import 'package:flutter_explosive_like/eye_modeling.dart';
import 'package:flutter_explosive_like/fablab_iot_screen.dart';
import 'package:flutter_explosive_like/faceId_lock_unlock_screen.dart';
import 'package:flutter_explosive_like/fade_in_out_text_animation.dart';
import 'package:flutter_explosive_like/family_tree.dart';
import 'package:flutter_explosive_like/favorite_screen.dart';
import 'package:flutter_explosive_like/feedback_form_screen.dart';
import 'package:flutter_explosive_like/fitness_screen.dart';
import 'package:flutter_explosive_like/flight_seat_booking_screen.dart';
import 'package:flutter_explosive_like/fluttering_butterfly_loading.dart';
import 'package:flutter_explosive_like/fortune_wheel_screen.dart';
import 'package:flutter_explosive_like/fruit_cutting_animation.dart';
import 'package:flutter_explosive_like/function_drawer_screen.dart';
import 'package:flutter_explosive_like/game_2048_screen.dart';
import 'package:flutter_explosive_like/glass_filling_up_screen.dart';
import 'package:flutter_explosive_like/gmail_screen.dart';
import 'package:flutter_explosive_like/gradient_background_generator.dart';
import 'package:flutter_explosive_like/gradient_loading.dart';
import 'package:flutter_explosive_like/hacker_screen.dart';
import 'package:flutter_explosive_like/heart_beat_pulse_loading.dart';
import 'package:flutter_explosive_like/hexagon_grid_loading.dart';
import 'package:flutter_explosive_like/home_automation_screen.dart';
import 'package:flutter_explosive_like/home_page.dart';
import 'package:flutter_explosive_like/hourglass_loader_screen.dart';
import 'package:flutter_explosive_like/image_cropper.dart';
import 'package:flutter_explosive_like/instagram_feed_screen.dart';
import 'package:flutter_explosive_like/interactive_button.dart';
import 'package:flutter_explosive_like/invoice_screen.dart';
import 'package:flutter_explosive_like/iot_screen.dart';
import 'package:flutter_explosive_like/itinerary_timeline.dart';
import 'package:flutter_explosive_like/job_hiring.dart';
import 'package:flutter_explosive_like/job_listing_screen.dart';
import 'package:flutter_explosive_like/joystick.dart';
import 'package:flutter_explosive_like/juice_animation.dart';
import 'package:flutter_explosive_like/kakuro_game_screen.dart';
import 'package:flutter_explosive_like/landing_page_screen.dart';
import 'package:flutter_explosive_like/leader_board_screen.dart';
import 'package:flutter_explosive_like/linkedin_feed_screen.dart';
import 'package:flutter_explosive_like/liquid_linear_pogress_indicator.dart';
import 'package:flutter_explosive_like/liquid_simulation_screen.dart';
import 'package:flutter_explosive_like/liquid_stepper_demo.dart';
import 'package:flutter_explosive_like/manga_reader_screen.dart';
import 'package:flutter_explosive_like/match_score.dart';
import 'package:flutter_explosive_like/math_func_calculator_screen.dart';
import 'package:flutter_explosive_like/maze_game_screen.dart';
import 'package:flutter_explosive_like/meeting_room_screen.dart';
import 'package:flutter_explosive_like/memory_match_game.dart';
import 'package:flutter_explosive_like/menu_screen.dart';
import 'package:flutter_explosive_like/meteo_viewer_screen.dart';
import 'package:flutter_explosive_like/morphing_shape_loading.dart';
import 'package:flutter_explosive_like/moving_lines_loading.dart';
import 'package:flutter_explosive_like/music_player.screen.dart';
import 'package:flutter_explosive_like/nearbest_screen.dart';
import 'package:flutter_explosive_like/neon_text_animation.dart';
import 'package:flutter_explosive_like/news_reader_screen.dart';
import 'package:flutter_explosive_like/on_off_screen.dart';
import 'package:flutter_explosive_like/onboarding_screen.dart';
import 'package:flutter_explosive_like/onboarding_screen10.dart';
import 'package:flutter_explosive_like/onboarding_screen11.dart';
import 'package:flutter_explosive_like/onboarding_screen12.dart';
import 'package:flutter_explosive_like/onboarding_screen13.dart';
import 'package:flutter_explosive_like/onboarding_screen14.dart';
import 'package:flutter_explosive_like/onboarding_screen15.dart';
import 'package:flutter_explosive_like/onboarding_screen16.dart';
import 'package:flutter_explosive_like/onboarding_screen17.dart';
import 'package:flutter_explosive_like/onboarding_screen18.dart';
import 'package:flutter_explosive_like/onboarding_screen19.dart';
import 'package:flutter_explosive_like/onboarding_screen2.dart';
import 'package:flutter_explosive_like/onboarding_screen20.dart';
import 'package:flutter_explosive_like/onboarding_screen21.dart';
import 'package:flutter_explosive_like/onboarding_screen22.dart';
import 'package:flutter_explosive_like/onboarding_screen23.dart';
import 'package:flutter_explosive_like/onboarding_screen24.dart';
import 'package:flutter_explosive_like/onboarding_screen25.dart';
import 'package:flutter_explosive_like/onboarding_screen26.dart';
import 'package:flutter_explosive_like/onboarding_screen27.dart';
import 'package:flutter_explosive_like/onboarding_screen28.dart';
import 'package:flutter_explosive_like/onboarding_screen3.dart';
import 'package:flutter_explosive_like/onboarding_screen30.dart';
import 'package:flutter_explosive_like/onboarding_screen31.dart';
import 'package:flutter_explosive_like/onboarding_screen32.dart';
import 'package:flutter_explosive_like/onboarding_screen33.dart';
import 'package:flutter_explosive_like/onboarding_screen34.dart';
import 'package:flutter_explosive_like/onboarding_screen35.dart';
import 'package:flutter_explosive_like/onboarding_screen36.dart';
import 'package:flutter_explosive_like/onboarding_screen37.dart';
import 'package:flutter_explosive_like/onboarding_screen4.dart';
import 'package:flutter_explosive_like/onboarding_screen5.dart';
import 'package:flutter_explosive_like/onboarding_screen6.dart';
import 'package:flutter_explosive_like/onboarding_screen7.dart';
import 'package:flutter_explosive_like/onboarding_screen8.dart';
import 'package:flutter_explosive_like/onboarding_screen9.dart';
import 'package:flutter_explosive_like/palette_generate_screen.dart';
import 'package:flutter_explosive_like/parallax_scrolling_demo.dart';
import 'package:flutter_explosive_like/parallel_universe_screen.dart';
import 'package:flutter_explosive_like/parking_lot_screen.dart';
import 'package:flutter_explosive_like/particle_loading.dart';
import 'package:flutter_explosive_like/percentage_ring_loading.dart';
import 'package:flutter_explosive_like/phone_book_screen.dart';
import 'package:flutter_explosive_like/physic_game.dart';
import 'package:flutter_explosive_like/pill_loader_screen.dart';
import 'package:flutter_explosive_like/pinball_tenis_game.dart';
import 'package:flutter_explosive_like/podcast_player_screen.dart';
import 'package:flutter_explosive_like/popup_overlay_screen.dart';
import 'package:flutter_explosive_like/post_application_screen.dart';
import 'package:flutter_explosive_like/post_login_home_screen.dart';
import 'package:flutter_explosive_like/post_login_home_screen10.dart';
import 'package:flutter_explosive_like/post_login_home_screen11.dart';
import 'package:flutter_explosive_like/post_login_home_screen12.dart';
import 'package:flutter_explosive_like/post_login_home_screen13.dart';
import 'package:flutter_explosive_like/post_login_home_screen14.dart';
import 'package:flutter_explosive_like/post_login_home_screen15.dart';
import 'package:flutter_explosive_like/post_login_home_screen16.dart';
import 'package:flutter_explosive_like/post_login_home_screen17.dart';
import 'package:flutter_explosive_like/post_login_home_screen18.dart';
import 'package:flutter_explosive_like/post_login_home_screen19.dart';
import 'package:flutter_explosive_like/post_login_home_screen2.dart';
import 'package:flutter_explosive_like/post_login_home_screen3.dart';
import 'package:flutter_explosive_like/post_login_home_screen4.dart';
import 'package:flutter_explosive_like/post_login_home_screen5.dart';
import 'package:flutter_explosive_like/post_login_home_screen6.dart';
import 'package:flutter_explosive_like/post_login_home_screen7.dart';
import 'package:flutter_explosive_like/post_login_home_screen8.dart';
import 'package:flutter_explosive_like/post_login_home_screen9.dart';
import 'package:flutter_explosive_like/press_screen.dart';
import 'package:flutter_explosive_like/pricing_screen.dart';
import 'package:flutter_explosive_like/pulsating_loading_button.dart';
import 'package:flutter_explosive_like/pulsating_text_animation.dart';
import 'package:flutter_explosive_like/purchase_receip_screen.dart';
import 'package:flutter_explosive_like/puzzle_game_screen.dart';
import 'package:flutter_explosive_like/radar_screen.dart';
import 'package:flutter_explosive_like/radial_progress_bar.dart';
import 'package:flutter_explosive_like/rain_drops.dart';
import 'package:flutter_explosive_like/rainbow_sky_animation.dart';
import 'package:flutter_explosive_like/rainbow_text_animation.dart';
import 'package:flutter_explosive_like/recipe_order_screen.dart';
import 'package:flutter_explosive_like/reels_screen.dart';
import 'package:flutter_explosive_like/reminder_screen.dart';
import 'package:flutter_explosive_like/remote_control_screen.dart';
import 'package:flutter_explosive_like/responsive_widget_test_screen.dart';
import 'package:flutter_explosive_like/rocket_loading.dart';
import 'package:flutter_explosive_like/rotating_cube_loading.dart';
import 'package:flutter_explosive_like/rotating_text_animation.dart';
import 'package:flutter_explosive_like/rotative_phone_keyboard.dart';
import 'package:flutter_explosive_like/rubick_cube_loader_screen.dart';
import 'package:flutter_explosive_like/rubiks_cube_game.dart';
import 'package:flutter_explosive_like/sea_wave_animation_screen.dart';
import 'package:flutter_explosive_like/sensitive_content_style_on_image.dart';
import 'package:flutter_explosive_like/shimmer_text_loading.dart';
import 'package:flutter_explosive_like/sliding_bar_loading.dart';
import 'package:flutter_explosive_like/space_animation.dart';
import 'package:flutter_explosive_like/space_shooter.dart';
import 'package:flutter_explosive_like/spring_effect.dart';
import 'package:flutter_explosive_like/stacked_cards_screen.dart';
import 'package:flutter_explosive_like/stickman.dart';
import 'package:flutter_explosive_like/swipe_to_pay_screen.dart';
import 'package:flutter_explosive_like/scientific_calculator_screen.dart';
import 'package:flutter_explosive_like/search_screen.dart';
import 'package:flutter_explosive_like/search_screen2.dart';
import 'package:flutter_explosive_like/settings_screen.dart';
import 'package:flutter_explosive_like/sharingan_to_mangekyou_screen.dart';
import 'package:flutter_explosive_like/shorts_screen.dart';
import 'package:flutter_explosive_like/signin_screen.dart';
import 'package:flutter_explosive_like/signin_screen2.dart';
import 'package:flutter_explosive_like/signin_screen3.dart';
import 'package:flutter_explosive_like/signin_screen4.dart';
import 'package:flutter_explosive_like/signup_screen.dart';
import 'package:flutter_explosive_like/snake_game_screen.dart';
import 'package:flutter_explosive_like/special_offer_screen.dart';
import 'package:flutter_explosive_like/stock_list_screen.dart';
import 'package:flutter_explosive_like/subscription_screen.dart';
import 'package:flutter_explosive_like/teams_generator_screen.dart';
import 'package:flutter_explosive_like/test_screen.dart';
import 'package:flutter_explosive_like/testimonial_screen.dart';
import 'package:flutter_explosive_like/tetris_game_screen.dart';
import 'package:flutter_explosive_like/text_bounce_animation.dart';
import 'package:flutter_explosive_like/text_flicker_animation.dart';
import 'package:flutter_explosive_like/text_flip_card_animation.dart';
import 'package:flutter_explosive_like/text_flip_fall_animation.dart';
import 'package:flutter_explosive_like/text_gradient_animation.dart';
import 'package:flutter_explosive_like/text_masking_animation.dart';
import 'package:flutter_explosive_like/text_ripple_animation.dart';
import 'package:flutter_explosive_like/text_scalling_animation.dart';
import 'package:flutter_explosive_like/text_shake_animation.dart';
import 'package:flutter_explosive_like/text_stacking_animation.dart';
import 'package:flutter_explosive_like/text_wave_animation.dart';
import 'package:flutter_explosive_like/three_d_model_screen.dart';
import 'package:flutter_explosive_like/time_travel_screen.dart';
import 'package:flutter_explosive_like/timetable_screen.dart';
import 'package:flutter_explosive_like/torch_effect_screen.dart';
import 'package:flutter_explosive_like/torch_screen.dart';
import 'package:flutter_explosive_like/tourism_screen.dart';
import 'package:flutter_explosive_like/trampoline_animation.dart';
import 'package:flutter_explosive_like/translator_screen.dart';
import 'package:flutter_explosive_like/tv_app_screen.dart';
import 'package:flutter_explosive_like/typewriter_text_animation.dart';
import 'package:flutter_explosive_like/user_profile_screen.dart';
import 'package:flutter_explosive_like/onboarding_screen29.dart';
import 'package:flutter_explosive_like/water_level_slider.dart';
import 'package:flutter_explosive_like/wave_loading.dart';
import 'package:flutter_explosive_like/weather_animation_screen.dart';
import 'package:flutter_explosive_like/search_engine_screen.dart';
import 'package:flutter_explosive_like/weather_inspired_loading.dart';
import 'package:flutter_explosive_like/word_association_game.dart';
import 'package:flutter_explosive_like/word_search_game.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'automate/ui/screens/automate_home_screen.dart';
import 'blocpattern/employee_bloc.dart';
import 'blocpattern/employee_repository.dart';
import 'blocpattern/employee_view.dart';
import 'custom_analog_clock.dart';
import 'custom_image_reveal_animation.dart';
import 'file_dropzone.dart';
import 'morpion_game.dart';
import 'slate_drawing/slate_drawing_screen.dart';
import 'spider_animation.dart';
import 'spinning_animation_card.dart';
import 'whack_a_mole_game.dart';





void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('photos');
  // await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  SystemChrome.restoreSystemUIOverlays();
  // SystemChrome.setSystemUIOverlayStyle(
  //   SystemUiOverlayStyle(statusBarColor: Colors.pink, )
  // );
  await SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeLeft]);
  // await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.light(
        // primarySwatch: Colors.blue,
        // visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true
      ),
      debugShowCheckedModeBanner: false,
      // home: ReelsScreen(videoAsset: "assets/opening2.mp4",),
      // home: ChangeNotifierProvider(
      //   create: (_) => ChatModel(),
      //   child: const ChatAnimationScreen(),
      // ),
      home: AutomateHomeScreen(),
      // home: BlocProvider(
      //   create: (context) => EmployeeBloc(employeeRepository: EmployeeRepository()),
      //   child: EmployeeView(),
      // ),
    );
  }
}

