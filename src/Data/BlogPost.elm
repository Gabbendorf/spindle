module Data.BlogPost exposing (..)


type alias BlogPost =
    { apprenticeName : String
    , date : String
    , title : String
    , content : String
    }


filterPostsByApprentice : Maybe String -> List BlogPost -> List BlogPost
filterPostsByApprentice apprenticeName blogPostList =
    case apprenticeName of
        Just name ->
            List.filter (\blogPost -> blogPost.apprenticeName == name) blogPostList

        Nothing ->
            blogPostList
