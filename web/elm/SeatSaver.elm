port module SeatSaver exposing(..)

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
  ([], Cmd.none)

main : Program Never
main =
  Html.App.program
    { init = init
    , update = update
    , view = view
    , subscriptions = subscriptions
    }

-- UPDATE

type Msg = Toggle Seat | SetSeats Model

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
    SetSeats seats ->
        (seats, Cmd.none)

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

-- SIGNAL

port seatLists : (Model -> msg) -> Sub msg

subscriptions : Model -> Sub Msg
subscriptions model =
  seatLists SetSeats
