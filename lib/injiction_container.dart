import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion/core/class/cached_user_info.dart';
import 'package:fashion/core/class/download_file.dart';
import 'package:fashion/core/class/record_voice.dart';
import 'package:fashion/core/class/seen_secreen.dart';
import 'package:fashion/core/services/crud.dart';
import 'package:fashion/core/services/firebase_database_service.dart';
import 'package:fashion/core/services/network_info.dart';
import 'package:fashion/core/services/websocket_service.dart';
import 'package:fashion/core/translation/lang_bloc/language_bloc.dart';
import 'package:fashion/feature/account/data/data/customer_service_remote_data_sources.dart';
import 'package:fashion/feature/account/data/data/f_a_qs_remote_data_sources.dart';
import 'package:fashion/feature/account/data/data/my_details_remote_data_source.dart';
import 'package:fashion/feature/account/data/data/order_remote_data_source.dart';
import 'package:fashion/feature/account/data/repositories/cutomer_service_repositories_imp.dart';
import 'package:fashion/feature/account/data/repositories/f_a_qs_repositories_imp.dart';
import 'package:fashion/feature/account/data/repositories/my_details_repositories_imp.dart';
import 'package:fashion/feature/account/data/repositories/order_repositories_imp.dart';
import 'package:fashion/feature/account/domain/repositories/customer_service_repository.dart';
import 'package:fashion/feature/account/domain/repositories/f_a_qs_repositories.dart';
import 'package:fashion/feature/account/domain/repositories/my_details_repositiories.dart';
import 'package:fashion/feature/account/domain/repositories/order_repositories.dart';
import 'package:fashion/feature/account/domain/usecase/customer_service_websocket/disconnect_server_use_case.dart';
import 'package:fashion/feature/account/domain/usecase/customer_service_websocket/leave_chat_use_case.dart';
import 'package:fashion/feature/account/domain/usecase/faqs/get_general_f_a_qs_usecase.dart';
import 'package:fashion/feature/account/domain/usecase/faqs/get_search_f_a_qs_usecase.dart';
import 'package:fashion/feature/account/domain/usecase/mydetails/up_date_my_details_usecase.dart';
import 'package:fashion/feature/account/domain/usecase/order/get_order_completed_usecase.dart';
import 'package:fashion/feature/account/domain/usecase/order/get_oreder_ongoing_usecase.dart';
import 'package:fashion/feature/account/presentation/controller/customer_service/customer_service_bloc.dart';
import 'package:fashion/feature/account/presentation/controller/customser_service_websocket/customer_service_websocket_bloc.dart';
import 'package:fashion/feature/account/presentation/controller/faqs/fa_qs_bloc.dart';
import 'package:fashion/feature/account/presentation/controller/myDetails/my_details_bloc.dart';
import 'package:fashion/feature/account/presentation/controller/order/order_bloc.dart';
import 'package:fashion/feature/account/presentation/controller/track_order/track_order_bloc.dart';
import 'package:fashion/feature/cart/data/data/remote_data_source_cart.dart';
import 'package:fashion/feature/cart/data/repositories/cart_repositories_imp.dart';
import 'package:fashion/feature/cart/domain/repositories/cart_repositories.dart';
import 'package:fashion/feature/cart/domain/usecase/add_one_piece_usecase.dart';
import 'package:fashion/feature/cart/domain/usecase/delete_all_piece_usecase.dart';
import 'package:fashion/feature/cart/domain/usecase/get_cart_usecase.dart';
import 'package:fashion/feature/cart/domain/usecase/remove_one_piece_usecase.dart';
import 'package:fashion/feature/cart/presentation/controller/controller/cart_bloc.dart';
import 'package:fashion/feature/checkout/data/data/remote_data_source_checkout.dart';
import 'package:fashion/feature/checkout/data/repositories/checkout_repositories_imp.dart';
import 'package:fashion/feature/checkout/domin/repositories/checkout_repositories.dart';
import 'package:fashion/feature/checkout/domin/usecase/add_card_usecase.dart';
import 'package:fashion/feature/checkout/domin/usecase/add_location_usecase.dart';
import 'package:fashion/feature/checkout/domin/usecase/add_order_usecase.dart';
import 'package:fashion/feature/checkout/domin/usecase/get_all_card_usecase.dart';
import 'package:fashion/feature/checkout/domin/usecase/get_all_location_usecase.dart';
import 'package:fashion/feature/checkout/domin/usecase/get_default_card_usecase.dart';
import 'package:fashion/feature/checkout/domin/usecase/get_default_location_usecase.dart';
import 'package:fashion/feature/checkout/presentation/controller/add_card/add_card_bloc.dart';
import 'package:fashion/feature/checkout/presentation/controller/add_loaction/add_location_bloc.dart';
import 'package:fashion/feature/checkout/presentation/controller/checkout/checkout_bloc.dart';
import 'package:fashion/feature/home/data/data/local_data_source.dart';
import 'package:fashion/feature/home/data/data/remote_data_source_home.dart';
import 'package:fashion/feature/home/data/repositories/home_repositories_imp.dart';
import 'package:fashion/feature/home/domain/ropositories/home_repository.dart';
import 'package:fashion/feature/home/domain/usecase/get_all_product_usecase.dart';
import 'package:fashion/feature/home/domain/usecase/get_category_usecase.dart';
import 'package:fashion/feature/home/domain/usecase/get_max_price_product_usecase.dart';
import 'package:fashion/feature/home/domain/usecase/get_max_price_usecase.dart';
import 'package:fashion/feature/home/domain/usecase/get_product_usecase.dart';
import 'package:fashion/feature/home/domain/usecase/high_low_price_allproduct_usecase.dart';
import 'package:fashion/feature/home/domain/usecase/high_low_price_product_usecase.dart';
import 'package:fashion/feature/home/domain/usecase/low_high_price_allproduct_usecase.dart';
import 'package:fashion/feature/home/domain/usecase/low_high_price_product_usecase.dart';
import 'package:fashion/feature/home/domain/usecase/range_price_allproduct_usecase.dart';
import 'package:fashion/feature/home/domain/usecase/range_price_product_usecase.dart';
import 'package:fashion/feature/home/presentation/controller/controller/home_bloc_bloc.dart';
import 'package:fashion/feature/notification/data/data/remote_data_source_notifi.dart';
import 'package:fashion/feature/notification/data/repositories/notification_repositories_imp.dart';
import 'package:fashion/feature/notification/domain/usercase/get_all_notifi_usecase.dart';
import 'package:fashion/feature/notification/domain/usercase/get_numb_notifi_not_read_usecase.dart';
import 'package:fashion/feature/notification/domain/usercase/read_all_notification_usercase.dart';
import 'package:fashion/feature/notification/presentation/controller/controller/notification_bloc.dart';
import 'package:fashion/feature/product_details/data/data/remote_data_source_product_detailes.dart';
import 'package:fashion/feature/product_details/data/repositories/product_details_repositories_imp.dart';
import 'package:fashion/feature/product_details/domain/repositories/product_details_repositories.dart';
import 'package:fashion/feature/product_details/domain/usecase/colors_usecase.dart';
import 'package:fashion/feature/product_details/domain/usecase/count_group_rating_usecase.dart';
import 'package:fashion/feature/product_details/domain/usecase/reviews_usecase.dart';
import 'package:fashion/feature/product_details/domain/usecase/size_usecase.dart';
import 'package:fashion/feature/product_details/presentation/controller/controller/product_details_bloc.dart';
import 'package:fashion/feature/product_details/presentation/controller/reviews/reviews_bloc.dart';
import 'package:fashion/feature/saved/data/data/remote_data_source_saved_product.dart';
import 'package:fashion/feature/saved/data/repositories/saved_product_repositories_imp.dart';
import 'package:fashion/feature/saved/domine/repositories/saved_product_repository.dart';
import 'package:fashion/feature/saved/domine/usecase/add_to_saved_usecase.dart';
import 'package:fashion/feature/saved/domine/usecase/get_saved_product_usecase.dart';
import 'package:fashion/feature/saved/domine/usecase/remove_all_saved_usecase.dart';
import 'package:fashion/feature/saved/domine/usecase/remove_from_saved_usercase.dart';
import 'package:fashion/feature/saved/presentation/controller/controller/saved_bloc.dart';
import 'package:fashion/feature/search/data/data/search_locale_data_source.dart';
import 'package:fashion/feature/search/data/data/search_remote_data_source.dart';
import 'package:fashion/feature/search/data/repository/search_repository_imp.dart';
import 'package:fashion/feature/search/domain/repository/search_repository.dart';
import 'package:fashion/feature/search/domain/usecase/cached_result_use_case.dart';
import 'package:fashion/feature/search/domain/usecase/get_cach_result_use_case.dart';
import 'package:fashion/feature/search/domain/usecase/get_result_use_case.dart';
import 'package:fashion/feature/search/domain/usecase/remove_all_cach_result_use_case.dart';
import 'package:fashion/feature/search/domain/usecase/remove_one_cached_result_use_case.dart';
import 'package:fashion/feature/search/presentation/controller/controller/search_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:record/record.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'core/services/firebase_auth_service.dart';
import 'core/services/location_services.dart';
import 'core/theme/bloc/theme_bloc.dart';
import 'feature/account/domain/usecase/customer_service_firebase/get_message_usecase.dart';
import 'feature/account/domain/usecase/customer_service_firebase/send_message_usecase.dart';
import 'feature/account/domain/usecase/customer_service_firebase/send_voice_use_case.dart';
import 'feature/account/domain/usecase/customer_service_websocket/init_websocket_use_case.dart';
import 'feature/account/domain/usecase/customer_service_websocket/send_messages_use_case.dart';
import 'feature/account/domain/usecase/faqs/get_topic_f_a_qs_usecase.dart';
import 'feature/account/domain/usecase/order/get_delivery_details_usecase.dart';
import 'feature/account/domain/usecase/order/get_my_location_usercase.dart';
import 'feature/account/domain/usecase/order/rating_order_usecase.dart';
import 'feature/auth/data/datasources/remote_data_source_auth.dart';
import 'feature/auth/data/repositories/auth_repositories_imp.dart';
import 'feature/auth/domain/repositories/auth_repositories.dart';
import 'feature/auth/domain/usecases/enter_email_usercase.dart';
import 'feature/auth/domain/usecases/log_in_usercase.dart';
import 'feature/auth/domain/usecases/login_with_google_usecase.dart';
import 'feature/auth/domain/usecases/resend_verifi_code_usercase.dart';
import 'feature/auth/domain/usecases/reset_password_usecase.dart';
import 'feature/auth/domain/usecases/sign_up_usecase.dart';
import 'feature/auth/domain/usecases/signup_with_google_usercase.dart';
import 'feature/auth/domain/usecases/verifi_email_pass_usercase.dart';
import 'feature/auth/domain/usecases/verifi_user_email_usercase.dart';
import 'feature/auth/presentation/controller/login/login_bloc.dart';
import 'feature/auth/presentation/controller/onbording/onboarding_bloc.dart';
import 'feature/auth/presentation/controller/reset_password/enter_email/enter_email_bloc.dart';
import 'feature/auth/presentation/controller/reset_password/reset_password/reset_password_bloc.dart';
import 'feature/auth/presentation/controller/reset_password/verifi_email_for_reset/verifi_email_bloc.dart';
import 'feature/auth/presentation/controller/signup/signup/signup_bloc.dart';
import 'feature/auth/presentation/controller/signup/verifi_signup/verifi_signup_bloc.dart';
import 'feature/checkout/domin/usecase/add_coupon_usecase.dart';
import 'feature/notification/data/data/local_data_source_notific.dart';
import 'feature/notification/domain/repositories/notific_repositories.dart';
import 'feature/product_details/domain/usecase/add_to_cart_usecase.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //=========================== EXTERNAL
  final sharedPreferences = await SharedPreferences.getInstance();

  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  // sl.registerLazySingleton(() => FlutterDownloader());
  sl.registerLazySingleton(() => InternetConnectionChecker.createInstance());
  sl.registerLazySingleton(() => GoogleSignIn());
  sl.registerLazySingleton(() => FirebaseDatabase.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => AudioRecorder());
  // sl.registerLazySingleton(() => )
  sl.registerLazySingleton(() => MapController());
  // sl.registerLazySingleton(() => re)
  // ============================<<<CORE>>>============================
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImp(sl()));
  sl.registerLazySingleton(() => Crud(sl()));
  sl.registerLazySingleton(() => SeenSecreen());
  sl.registerFactory(() => LanguageBloc());
  sl.registerFactory(() => ThemeBloc());
  sl.registerLazySingleton(() => FirebaseAuthService(sl(), sl()));
  sl.registerLazySingleton(() => CachedUserInfo());
  sl.registerLazySingleton(() => LocationServices());
  sl.registerLazySingleton(() => FirebaseDatabaseService());
  sl.registerLazySingleton(() => RecordVoice(sl()));
  sl.registerLazySingleton(() => WebSocketService());
  sl.registerLazySingleton(() => DownloadFile());

  //=============================<<<features>>>=========================

  //                             Auth
  //controller
  sl.registerFactory(() => OnboardingBloc(sl()));
  sl.registerFactory(() => LoginBloc(sl(), sl(), sl(), sl(), sl()));
  sl.registerFactory(() => SignupBloc(sl(), sl(), sl(), sl()));
  sl.registerFactory(() => VerifiSignupBloc(sl(), sl()));
  sl.registerFactory(() => EnterEmailBloc(sl()));
  sl.registerFactory(() => VerifiEmailBloc(sl(), sl()));
  sl.registerFactory(() => ResetPasswordBloc(sl()));
  //repositories
  sl.registerLazySingleton<AuthRepositories>(
    () => AuthRepositoriesImp(remoteDataSourceAuth: sl(), networkInfo: sl()),
  );
  //dataSources
  sl.registerLazySingleton<RemoteDataSourceAuth>(
    () => RemoteDataSourceAuthWithHttp(sl(), sl()),
  );
  //userCase
  sl.registerLazySingleton(() => EnterEmailUsercase(sl()));
  sl.registerLazySingleton(() => LogInUsercase(sl()));
  sl.registerLazySingleton(() => ResetPasswordUsecase(sl()));
  sl.registerLazySingleton(() => ResendVerifiCodeUsercase(sl()));
  sl.registerLazySingleton(() => SignUpUsecase(sl()));
  sl.registerLazySingleton(() => VerifiEmailPassUsercase(sl()));
  sl.registerLazySingleton(() => VerifiUserEmailUsercase(sl()));
  sl.registerLazySingleton(() => SignupWithGoogleUsercase(sl()));
  sl.registerLazySingleton(() => LoginWithGoogleUsecase(sl()));

  //=============================  Home ===========================

  //== Controller
  sl.registerFactory(
    () => HomeBloc(
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
    ),
  );

  //== Repositories
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoriesImp(sl(), sl(), sl()),
  );

  //== DataSources
  sl.registerLazySingleton<RemoteDataSourceHome>(
    () => RemoteDataSourceHomeImpHttp(sl()),
  );
  sl.registerLazySingleton<LocalDataSource>(
    () => LocalDetaSourceSharedPref(sl()),
  );

  //== UseCase
  sl.registerLazySingleton(() => GetCategoryUsecase(sl()));
  sl.registerLazySingleton(() => GetAllProductUsecase(sl()));
  sl.registerLazySingleton(() => GetProductUsecase(sl()));
  sl.registerLazySingleton(() => GetMaxPriceUsecase(sl()));
  sl.registerLazySingleton(() => LowHighPriceAllproductUsecase(sl()));
  sl.registerLazySingleton(() => HighLowPriceAllproductUsecase(sl()));
  sl.registerLazySingleton(() => RangePriceAllproductUsecase(sl()));
  sl.registerLazySingleton(() => LowHighPriceProductUsecase(sl()));
  sl.registerLazySingleton(() => HighLowPriceProductUsecase(sl()));
  sl.registerLazySingleton(() => RangePriceProductUsecase(sl()));
  sl.registerLazySingleton(() => GetMaxPriceProductUsecase(sl()));

  //================================================================

  // ======================== Notification =========================
  //== Controller
  sl.registerFactory(() => NotificationBloc(sl(), sl(), sl(), sl()));

  //== Repositories
  sl.registerLazySingleton<NotificRepositories>(
    () => NotificationRepositoriesImp(sl(), sl(), sl()),
  );

  //== DataSources
  sl.registerLazySingleton<RemoteDataSourceNotification>(
    () => RemoteDateSourceNotifiHttp(sl()),
  );
  sl.registerLazySingleton<LocalDataSourceNotification>(
    () => LocalDataSourceNotifiSharedPrefer(sl()),
  );

  //== UseCase
  sl.registerLazySingleton(() => GetAllNotifiUsecase(sl()));
  sl.registerLazySingleton(() => GetNumbNotifiNotReadUsecase(sl()));
  sl.registerLazySingleton(() => ReadAllNotificationUsercase(sl()));

  //=========================== Search =============================

  //== Controller
  sl.registerFactory(() => SearchBloc(sl(), sl(), sl(), sl(), sl()));

  //== DataSources
  sl.registerLazySingleton<SearchLocaleDataSource>(
    () => SearchLocaleDataSourceSharedPref(sl()),
  );
  sl.registerLazySingleton<SearchRemoteDataSource>(
    () => SearchRemoteDataSourceWithHttp(sl()),
  );

  //== Repository
  sl.registerLazySingleton<SearchRepository>(
    () => SearchRepositoryImp(sl(), sl(), sl()),
  );

  //== UseCase
  sl.registerLazySingleton(() => GetResultUseCase(sl()));
  sl.registerLazySingleton(() => GetCachResultUseCase(sl()));
  sl.registerLazySingleton(() => CachedResultUseCase(sl()));
  sl.registerLazySingleton(() => RemoveAllCachResultUseCase(sl()));
  sl.registerLazySingleton(() => RemoveOneCachedResultUseCase(sl()));

  //=========================== SAVED ===============================
  //== Controller
  sl.registerFactory(() => SavedBloc(sl(), sl(), sl(), sl(), sl()));
  //== Repositories

  sl.registerLazySingleton<SavedProductRepository>(
    () => SavedProductRepositoriesImp(sl(), sl()),
  );

  //== DataSources

  sl.registerLazySingleton<RemoteDataSourceSavedProduct>(
    () => RemotDataSavedProductWithHttp(sl()),
  );

  //== UseCase

  sl.registerLazySingleton(() => GetSavedProductUsecase(sl()));
  sl.registerLazySingleton(() => AddToSavedUsecase(sl()));
  sl.registerLazySingleton(() => RemoveFromSavedUsercase(sl()));
  sl.registerLazySingleton(() => RemoveAllSavedUsecase(sl()));

  //========================= product Details ===========================
  //== Controller
  sl.registerFactory(() => ProductDetailsBloc(sl(), sl(), sl(), sl()));
  sl.registerFactory(() => ReviewsBloc(sl(), sl()));
  //== Repositories
  sl.registerLazySingleton<ProductDetailsRepositories>(
    () => ProductDetailsRepositoriesImp(sl(), sl()),
  );
  //== DataSources
  sl.registerLazySingleton<RemoteDataSourceProductDetailes>(
    () => RemoteDataProductDetailsWithHttp(sl()),
  );
  //== UseCase
  sl.registerLazySingleton(() => SizesUsecase(sl()));
  sl.registerLazySingleton(() => ColorsUsecase(sl()));
  sl.registerLazySingleton(() => AddToCartUsecase(sl()));
  sl.registerLazySingleton(() => CountGroupRatingUsecase(sl()));
  sl.registerLazySingleton(() => ReviewsUsecase(sl()));

  // =============================  CART ===================
  // controller

  sl.registerFactory(() => CartBloc(sl(), sl(), sl(), sl()));
  // Repositories
  sl.registerLazySingleton<CartRepositories>(
    () => CartRepositoriesImp(sl(), sl()),
  );
  //DataSources
  sl.registerLazySingleton<RemoteDataSourceCart>(
    () => RemoteDataSourceCartWithHttp(sl()),
  );
  //UseCase
  sl.registerLazySingleton(() => GetCartUsecase(sl()));
  sl.registerLazySingleton(() => AddOnePieceUsecase(sl()));
  sl.registerLazySingleton(() => DeleteAllPieceUsecase(sl()));
  sl.registerLazySingleton(() => RemoveOnePieceUsecase(sl()));

  //========================== checkoutAndLoctionAndCard =================

  //controller
  sl.registerLazySingleton(
    () => CheckoutBloc(sl(), sl(), sl(), sl(), sl(), sl()),
  );
  sl.registerFactory(() => AddCardBloc(sl()));
  sl.registerFactory(() => AddLocationBloc(sl(), sl(), sl()));

  // Repositories
  sl.registerLazySingleton<CheckoutRepositories>(
    () => CheckoutRepositoriesImp(sl(), sl()),
  );

  //DataSources
  sl.registerLazySingleton<RemoteDataSourceCheckout>(
    () => RemoteDataCheckOutWithHttp(sl()),
  );
  //userCase
  sl.registerLazySingleton(() => GetDefaultLocationUsecase(sl()));
  sl.registerLazySingleton(() => GetDefaultCardUsecase(sl()));
  sl.registerLazySingleton(() => GetAllLocationUsecase(sl()));
  sl.registerLazySingleton(() => GetAllCardUsecase(sl()));
  sl.registerLazySingleton(() => AddCardUsecase(sl()));
  sl.registerLazySingleton(() => AddLocationUsecase(sl()));
  sl.registerLazySingleton(() => AddCouponUsecase(sl()));
  sl.registerLazySingleton(() => AddOrderUsecase(sl()));

  //=============================  MyOrder =========================
  // controller
  sl.registerFactory(() => OrderBloc(sl(), sl(), sl()));
  sl.registerFactory(() => TrackOrderBloc(sl(), sl()));

  // repositories
  sl.registerLazySingleton<OrderRepositories>(
    () => OrderRepositoriesImp(sl(), sl()),
  );

  // DataSource

  sl.registerLazySingleton<OrderRemoteDataSource>(
    () => OrderRemoteDataWithHttp(sl()),
  );

  //usecase

  sl.registerLazySingleton(() => GetOrderCompletedUsecase(sl()));
  sl.registerLazySingleton(() => GetOrederOngoingUsecase(sl()));
  sl.registerLazySingleton(() => RatingOrderUsecase(sl()));
  sl.registerLazySingleton(() => GetMyLocationUsecase(sl()));
  sl.registerLazySingleton(() => GetDeliveryDetailsUsecase(sl()));

  // ========================== MyDetails =====================
  // controller
  sl.registerFactory(() => MyDetailsBloc(sl()));
  //repositories
  sl.registerLazySingleton<MyDetailsRepositiories>(
    () => MyDetailsRepositoriesImp(sl(), sl()),
  );
  //DataSources
  sl.registerLazySingleton<MyDetailsRemoteDataSource>(
    () => MyDetailsRemoteDataWithHttp(sl()),
  );
  //usecase
  sl.registerLazySingleton(() => UpDateMyDetailsUsecase(sl()));

  //=========================== FAQs ============================
  // controller
  sl.registerFactory(() => FaQsBloc(sl(), sl(), sl()));
  //repositories
  sl.registerLazySingleton<FAQsRepositories>(
    () => FAQsRepositoriesImp(sl(), sl()),
  );
  //DataSources
  sl.registerLazySingleton<FAQsRemoteDataSources>(
    () => FAQsRemoteDataWithHttp(sl()),
  );
  //usecase
  sl.registerLazySingleton(() => GetGeneralFAQsUsecase(sl()));
  sl.registerLazySingleton(() => GetTopicFAQsUsecase(sl()));
  sl.registerLazySingleton(() => GetSearchFAQsUsecase(sl()));

  // ========================= customerService =====================
  // controller

  sl.registerFactory(() => CustomerServiceBloc(sl(), sl(), sl(), sl()));
  sl.registerFactory(
    () => CustomerServiceWebsocketBloc(sl(), sl(), sl(), sl(), sl(), sl()),
  );
  // repositories
  sl.registerLazySingleton<CustomerServiceRepositoryFirebase>(
    () => CustomerServiceRepositoriesImp(sl(), sl()),
  );
  sl.registerLazySingleton<CustomerServiceRepositoryWebsoket>(
    () => CustomerServiceRepositoriesWebSocketImp(sl(), sl()),
  );
  // DataSources
  sl.registerLazySingleton(
    () => CustomerServiceRemoteWebsocketDataSource(sl(), sl()),
  );
  sl.registerLazySingleton<CustomerServiceRemoteDataSources>(
    () => CustomerServiceRemoteFirestoreDataSource(sl(), sl()),
  );
  //   usecase
  //fireStore
  sl.registerLazySingleton(() => GetMessageUseCase(sl()));
  sl.registerLazySingleton(() => SendMessageUseCase(sl()));
  sl.registerLazySingleton(() => SendVoiceUseCase(sl()));

  //websocket
  sl.registerLazySingleton(() => InitWebsocketUseCase(sl()));
  sl.registerLazySingleton(() => SendMessagesUseCase(sl()));
  sl.registerLazySingleton(() => DisconnectServerUseCase(sl()));
  sl.registerLazySingleton(() => LeaveChatUseCase(sl()));
}
