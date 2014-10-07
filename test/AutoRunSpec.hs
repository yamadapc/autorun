module AutoRunSpec where

import System.FilePath ((</>))
import Test.Hspec
import AutoRun

spec :: Spec
spec =
    describe "getRunTarget" $ do
        it "returns the correct run target for relative paths" $
            getRunTarget "/Something/" "../something.js" `shouldBe`
              RunTarget "node:latest" "node" ("/Something/" </> "../something.js") ".js"

        it "returns the correct run target for absolute paths" $
            getRunTarget "/Something/" "/asdf/something.js" `shouldBe`
              RunTarget "node:latest" "node" "/asdf/something.js" ".js"
