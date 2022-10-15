import 'package:beauty_supplies_project/models/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../services/firestore_services.dart';
import '../../../utilities/firebase_collections_path.dart';
import 'carousel_slider_images_state.dart';

class CarouselSliderImagesCubit extends Cubit<CarouselSliderImagesState> {
  CarouselSliderImagesCubit() : super(CarouselSliderImagesInitial());

  final FirestoreServices _service = FirestoreServices.instance;

  Stream<List<CarouselSliderModel>> carouselSliderImagesStream() => _service.collectionsStream(
    path: FirebaseCollectionPath.carousel(),
    builder: (data, documentId) => CarouselSliderModel.fromMap(data!, documentId),
  );

}
