module SeatSaver exposing(..)

import Html exposing (ul, li, text, div, hr, Html)
import Html.Attributes exposing (class)
import Html.App
import Html.Events exposing (onClick)

type alias Seat =
  { seatNo : Int
  , occupied : Bool
  }

type alias Model =
  List Seat

init : (Model, Cmd msg)
init =
  let
    seats =
      [ { seatNo = 1, occupied = False }
      , { seatNo = 2, occupied = False }
      , { seatNo = 3, occupied = False }
      , { seatNo = 4, occupied = False }
      , { seatNo = 5, occupied = False }
      , { seatNo = 6, occupied = False }
      , { seatNo = 7, occupied = False }
      , { seatNo = 8, occupied = False }
      , { seatNo = 9, occupied = False }
      , { seatNo = 10, occupied = False }
      , { seatNo = 11, occupied = False }
      , { seatNo = 12, occupied = False }
      ]
  in
    (seats, Cmd.none)

main : Program Never
main =
  Html.App.program
    { init = init
    , update = update
    , view = view
    , subscriptions = \_ -> Sub.none
    }

-- UPDATE

type Msg = Toggle Seat

update : Msg -> Model -> (Model, Cmd msg)
update action model =
  case action of
    Toggle seatToToggle ->
      let
        updateSeat seatFromModel =
          if seatFromModel.seatNo == seatToToggle.seatNo then
            { seatFromModel | occupied = not seatFromModel.occupied }
          else seatFromModel
      in
        (List.map updateSeat model, Cmd.none)

-- VIEW

view : Model -> Html Msg
view model =
  div []
  [ ul [class "seats"] (List.indexedMap seatItem model)
  , hr [] []
  , text (toString model)
  ]

seatItem : Int -> Seat -> Html Msg
seatItem model seat =
  let
    occupiedClass =
      if seat.occupied then "occupied" else "available"
  in
    li
      [ class ("seat " ++ occupiedClass)
      , onClick (Toggle seat)
      ]
      [ text (toString seat.seatNo) ]
