;; combine-multi-audio-channels
;; This file Copyright (C) 2022 Brandon Hale

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.



(asdf:defsystem :combine-multi-channels
  :description "Combine audio channels from multiple files into a big multichannel file."
  :version "1.0"
  :author "Brandon Hale <bthaleproductions@gmail.com>"
  :license "GNU General Public License v3"
  :depends-on (#:py4cl)
  :components ((:file "combinemultichannels")))
