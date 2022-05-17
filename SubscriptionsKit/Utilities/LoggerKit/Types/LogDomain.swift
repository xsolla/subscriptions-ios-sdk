// Copyright 2021-present Xsolla (USA), Inc. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at q
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing and permissions and

import Foundation

struct LogDomain: LogDomainProtocol
{
    var title: String
    var emojiSymbol: String
    var description: String { title }

    /// Common, default domain, used when particular domain is not set
    static let common = Self.init(title: "Common")

    init(title: String, emojiSymbol: String = "")
    {
        self.title = title
        self.emojiSymbol = emojiSymbol
    }
}
