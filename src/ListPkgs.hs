{-
 - Copyright 2011 Per Magnus Therning
 -
 - Licensed under the Apache License, Version 2.0 (the "License");
 - you may not use this file except in compliance with the License.
 - You may obtain a copy of the License at
 -
 -     http://www.apache.org/licenses/LICENSE-2.0
 -
 - Unless required by applicable law or agreed to in writing, software
 - distributed under the License is distributed on an "AS IS" BASIS,
 - WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 - See the License for the specific language governing permissions and
 - limitations under the License.
 -}

module ListPkgs where

import Util.Misc
import PkgDB

import Control.Monad
import Control.Monad.Reader
import Data.Maybe
import Distribution.Text
import System.FilePath

listPkgs :: ReaderT Cmds IO ()
listPkgs = do
    iB <- cfgGet incBase
    db <- cfgGet dbFile >>= liftIO . readDb
    let pkgs = if not iB
            then filter (not . isBasePkg) db
            else db
    liftIO $ mapM_ printCblPkgShort pkgs

-- printCblPkgShort (p, (v, _, r)) =
printCblPkgShort p =
    putStrLn $ pkgName p ++ "  " ++ (display $ pkgVersion p) ++ "-" ++ pkgRelease p
