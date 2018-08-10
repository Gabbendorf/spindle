module Icons.Chevron exposing (..)

import Svg exposing (Svg)
import Svg.Attributes exposing (..)


chevron : String -> Svg msg
chevron color =
    Svg.svg
        [ viewBox "-1 0 21 17"
        , width "100%"
        ]
        [ Svg.g
            [ Svg.Attributes.class <| "chevron " ++ color
            , fill "none"
            , fillRule "evenodd"
            , stroke "#FF7C7C"
            , strokeWidth "1.5px"
            , strokeLinecap "round"
            , strokeLinejoin "round"
            , transform "translate(0 1)"
            ]
            [ Svg.polyline [ points "4.5 19.5 13.5 10.49 4.5 1.5", transform "rotate(90 9 10.5)" ] []
            , Svg.polyline [ points "4.5 13.5 13.5 4.49 4.5 -4.5", transform "rotate(90 9 4.5)" ] []
            ]
        ]
