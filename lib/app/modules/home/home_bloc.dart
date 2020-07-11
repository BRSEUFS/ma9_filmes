import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:ma9filmes/app/modules/home/repositories/filme_repository.dart';
import 'package:ma9filmes/shared/models/filme_model.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc extends BlocBase {
  final FilmeRepository _repo;

  final _filmes = BehaviorSubject<List<FilmeModel>>();
  final _isLoading = BehaviorSubject<bool>();

  Stream<List<FilmeModel>> get filmes => _filmes.stream;
  Stream<bool> get isLoading => _isLoading.stream;

  HomeBloc(this._repo){
    _getFilmes();
  }

  _getFilmes() async {
    var response = await _repo.getFilmes();

    if (response.sucess) {
      _filmes.add(response.data);
    } else {
      _filmes.addError(response.errors);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _filmes.close();
    _isLoading.close();
  }
}
