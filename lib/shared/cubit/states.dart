abstract class NewsStates {}

class NewsInitialState extends NewsStates{}

class BusinessNewsState extends NewsStates{}

class GetBusinessNewsSuccessState extends NewsStates{}

class GetBusinessNewsErrorState extends NewsStates{
  final String error;
  GetBusinessNewsErrorState(this.error);
}

class GetBusinessNewsLoadingState extends NewsStates{}

class SportsNewsState extends NewsStates{}

class GetSportsNewsSuccessState extends NewsStates{}

class GetSportsNewsErrorState extends NewsStates{
  final String error;
  GetSportsNewsErrorState(this.error);
}

class GetSportsNewsLoadingState extends NewsStates{}

class ScienceNewsState extends NewsStates{}

class GetScienceNewsSuccessState extends NewsStates{}

class GetScienceNewsErrorState extends NewsStates{
  final String error;
  GetScienceNewsErrorState(this.error);
}

class GetScienceNewsLoadingState extends NewsStates{}

class GetSearchNewsSuccessState extends NewsStates{}

class GetSearchNewsErrorState extends NewsStates{
  final String error;
  GetSearchNewsErrorState(this.error);
}

class GetSearchNewsLoadingState extends NewsStates{}

class SettingsState extends NewsStates{}

class SwitchAppThemeState extends NewsStates{}