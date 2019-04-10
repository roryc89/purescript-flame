module Examples.Input where

import Prelude

import Effect (Effect)
import Effect.Aff (Aff)
import Flame (Html)
import Flame as F
import Flame.Html.Element as HE
import Flame.Html.Event as HV
import Signal ((~>))
import Signal as S
import Signal.DOM (MouseButton(..))
import Signal.DOM as SD

type Model = Int

data Message = Increment | Decrement

init :: Model
init = 0

update :: _ Model -> Message -> Aff Model
update _ model = pure <<< case _ of
        Increment -> model + 1
        Decrement -> model - 1

view :: Model -> Html Message
view model = HE.main "main" [
        HE.button [HV.onClick Decrement] "-",
        HE.text $ show model,
        HE.button [HV.onClick Increment] "+"
]

main :: Effect Unit
main = do
        mouseSignal <- SD.mouseButtonPressed MouseLeftButton

        let incrementSignal = mouseSignal ~> const Increment

        F.mount "main" {
                init,
                update,
                view,
                inputs: [incrementSignal]
        }
