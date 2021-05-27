import '../../features/article/domain/entities/article.dart';
import '../../features/article/presentation/bloc/bloc.dart';

toggleFavorite(Article article, FavoritesBloc bloc) =>
    bloc.add(ToggleFavoriteArticle(article: article));
