module Data.BlogPost exposing (..)

import Set exposing (Set)


type alias BlogPost =
    { author : String
    , date : String
    , title : String
    , link : String
    , content : String
    }


isSelectedBlogPost : Maybe BlogPost -> BlogPost -> Bool
isSelectedBlogPost selectedBlogPost blogPost =
    case selectedBlogPost of
        Just post ->
            post == blogPost

        Nothing ->
            False


filterPostsByAuthor : Maybe String -> List BlogPost -> List BlogPost
filterPostsByAuthor selectedAuthor blogPostList =
    case selectedAuthor of
        Just author ->
            List.filter (\blogPost -> blogPost.author == author) blogPostList

        Nothing ->
            blogPostList


authorsList : List BlogPost -> Set String
authorsList blogPosts =
    blogPosts
        |> List.map (\blogPost -> blogPost.author)
        |> Set.fromList
