class AppState{
  String data;
  AppState({this.data});
  AppState.fromAppState(AppState appState){
    data = appState.data;
  }
}