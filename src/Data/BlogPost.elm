module Data.BlogPost exposing (..)


type alias BlogPost =
    { author : String
    , date : String
    , title : String
    , content : String
    }


filterPostsByAuthor : Maybe String -> List BlogPost -> List BlogPost
filterPostsByAuthor selectedAuthor blogPostList =
    case selectedAuthor of
        Just author ->
            List.filter (\blogPost -> blogPost.author == author) blogPostList

        Nothing ->
            blogPostList
