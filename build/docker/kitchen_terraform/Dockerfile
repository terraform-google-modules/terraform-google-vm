# Copyright 2018 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

ARG BASE_IMAGE

FROM $BASE_IMAGE

RUN apk add --no-cache \
    ca-certificates=20171114-r3

WORKDIR $APP_BASE_DIR/workdir
COPY Gemfile .
RUN bundle install

RUN gcloud components install beta --quiet
RUN gcloud components install alpha --quiet
