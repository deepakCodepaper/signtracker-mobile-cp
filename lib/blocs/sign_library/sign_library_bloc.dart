import 'package:bloc/bloc.dart';
import 'package:signtracker/api/model/sign_project.dart';
import 'package:signtracker/blocs/sign_library/sign_library_events.dart';
import 'package:signtracker/blocs/sign_library/sign_library_states.dart';
import 'package:signtracker/repository/sign_repository.dart';

class SignLibraryBloc extends Bloc<SignLibraryEvent, SignLibraryState> {
  SignLibraryBloc(this.signRepository);

  final SignRepository signRepository;

  @override
  get initialState => SignsLibaryInitial();

  void fetchSigns(int templateId) {
    add(FetchSigns(templateId));
  }

  void getallSignMasters() {
    add(FetchAllSigns());
  }

  void addSignToTemplate(SignProject project, int signId, bool addToMyTemplate,
      bool favouriteThisSign) {
    add(AddSignToTemplate(project, signId, addToMyTemplate, favouriteThisSign));
  }

  void deleteSignFromTemplate(SignProject project, int signId) {
    add(DeleteSignFromTemplate(project, signId));
  }

  void unFavouriteSign(SignProject project, int signId) {
    add(UnFavouriteSign(project, signId));
  }

  @override
  Stream<SignLibraryState> mapEventToState(SignLibraryEvent event) async* {
    if (event is FetchSigns) {
      yield SignsLibraryLoading();
      final signs = await signRepository.fetchSigns(event.templateId);
      if (signs == null) {
        yield SignLibraryError('Unable to load sign library.');
      } else {
        yield SignsLibraryLoaded(signs);
      }
    } else if (event is FetchAllSigns) {
      yield SignsLibraryLoading();
      final signs = await signRepository.fetchAllSigns();
      if (signs == null) {
        yield SignLibraryError('Unable to load sign library.');
      } else {
        yield SignsLibraryLoaded(signs);
      }
    } else if (event is AddSignToTemplate) {
      yield SignAddTemplateLoading();
      final template = await signRepository.addSignToTemplate(event.project,
          event.signId, event.addToTemplate, event.favouriteThisSign);
      print(template);
      if (template != null) {
        yield SignAddTemplateLoaded(template);
      } else {
        yield SignAddTemplateError();
      }
    } else if (event is DeleteSignFromTemplate) {
      yield DeleteSignFromTemplateLoading();
      final template = await signRepository.deleteSignFromTemplate(
          event.project, event.signId);
      print(template);
      if (template != null) {
        yield DeleteSignFromTemplateLoaded(template);
      } else {
        yield DeleteSignFromTemplateError();
      }
    } else if (event is UnFavouriteSign) {
      yield UnFavouriteSignLoading();
      final template =
          await signRepository.unFavouriteSign(event.project, event.signId);
      print(template);
      if (template != null) {
        yield UnFavouriteSignLoaded(template);
      } else {
        yield UnFavouriteSignError();
      }
    }
  }
}
