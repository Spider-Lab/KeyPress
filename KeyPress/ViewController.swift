/*
 ViewController.swift
 Copyright (C) 2020 Dieter Baron
 
 This file is part of KeyPress, an App displaying KeyPress events
 The authors can be contacted at <dbaron@spiderlab.at>
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions
 are met:
 1. Redistributions of source code must retain the above copyright
 notice, this list of conditions and the following disclaimer.
 2. The names of the authors may not be used to endorse or promote
 products derived from this software without specific prior
 written permission.
 
 THIS SOFTWARE IS PROVIDED BY THE AUTHORS ``AS IS'' AND ANY EXPRESS
 OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY
 DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE
 GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER
 IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
 OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
 IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

import UIKit

import ExternalAccessory

class ViewController: UIViewController {
    @IBOutlet weak var testView: UITextView!
    
    override func viewWillAppear(_ animated: Bool) {
        becomeFirstResponder()
    }
    
    override func pressesBegan(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        for press in presses {
            testView.text.append(contentsOf: "pressed " + string(for: press) + "\n")
        }
        scrolToBottom()
    }
    
    override func pressesEnded(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        for press in presses {
            testView.text.append(contentsOf: "released " + string(for: press) + "\n")
        }
        scrolToBottom()
    }

    struct ModfierName {
        let modifier: UIKeyModifierFlags
        let name: String
    }
    
    let modifierNames = [
        ModfierName(modifier: .alphaShift, name: "AlphaShift"),
        ModfierName(modifier: .alternate, name: "Alternate"),
        ModfierName(modifier: .command, name: "Command"),
        ModfierName(modifier: .control, name: "Control"),
        ModfierName(modifier: .numericPad, name: "NumericPad"),
        ModfierName(modifier: .shift, name: "Shift")
    ]
    
    struct SpecialKey {
        let code: UIKeyboardHIDUsage
        let name: String
    }
    
    let specialKeys = [
        SpecialKey(code: .keyboardUpArrow, name: "<Up>"),
        SpecialKey(code: .keyboardDownArrow, name: "<Down>"),
        SpecialKey(code: .keyboardLeftArrow, name: "<Left>"),
        SpecialKey(code: .keyboardRightArrow, name: "<Right>"),
        SpecialKey(code: .keyboardLeftShift, name: "<LeftShift>"),
        SpecialKey(code: .keyboardRightShift, name: "<RightShift>"),
        SpecialKey(code: .keyboardLeftControl, name: "<LeftControl>"),
        SpecialKey(code: .keyboardRightControl, name: "<RightControl>"),
        SpecialKey(code: .keyboardLeftAlt, name: "<LeftOption>"),
        SpecialKey(code: .keyboardRightAlt, name: "<RightOption>"),
        SpecialKey(code: .keyboardLeftGUI, name: "<LeftCommand>"),
        SpecialKey(code: .keyboardRightGUI, name: "<RightCommand>"),
        SpecialKey(code: .keyboardCapsLock, name: "<CapsLock>"),
        SpecialKey(code: .keyboardEscape, name: "<Escape>"),
        SpecialKey(code: .keyboardTab, name: "<Tab>"),
        SpecialKey(code: .keyboardDeleteOrBackspace, name: "<Delete>"),
        SpecialKey(code: .keyboardReturnOrEnter, name: "<Return>"),
        SpecialKey(code: .keyboardSpacebar, name: "<Space>"),
        SpecialKey(code: .keyboardF1, name: "<F1>"),
        SpecialKey(code: .keyboardF2, name: "<F2>"),
        SpecialKey(code: .keyboardF3, name: "<F3>"),
        SpecialKey(code: .keyboardF4, name: "<F4>"),
        SpecialKey(code: .keyboardF5, name: "<F5>"),
        SpecialKey(code: .keyboardF6, name: "<F6>"),
        SpecialKey(code: .keyboardF7, name: "<F7>"),
        SpecialKey(code: .keyboardF8, name: "<F8>"),
        SpecialKey(code: .keyboardF9, name: "<F9>"),
        SpecialKey(code: .keyboardF10, name: "<F10>"),
        SpecialKey(code: .keyboardF11, name: "<F11>"),
        SpecialKey(code: .keyboardF12, name: "<F12>"),
        SpecialKey(code: .keyboardF13, name: "<F13>"),
        SpecialKey(code: .keyboardF14, name: "<F14>"),
        SpecialKey(code: .keyboardF15, name: "<F15>"),
        SpecialKey(code: .keyboardF16, name: "<F16>"),
        SpecialKey(code: .keyboardF17, name: "<F17>"),
        SpecialKey(code: .keyboardF18, name: "<F18>"),
        SpecialKey(code: .keyboardF19, name: "<F19>"),
        SpecialKey(code: .keyboardF20, name: "<F20>"),
        SpecialKey(code: .keyboardF21, name: "<F21>"),
        SpecialKey(code: .keyboardF22, name: "<F22>"),
        SpecialKey(code: .keyboardF23, name: "<F23>"),
        SpecialKey(code: .keyboardF24, name: "<F24>"),
        SpecialKey(code: UIKeyboardHIDUsage(rawValue: 669)!, name: "<Globe>"),
    ]
    
    func string(for press: UIPress) -> String {
        guard let key = press.key else { return "<no key>" }

        var modifiers = [String]()

        for name in modifierNames {
            if key.modifierFlags.contains(name.modifier) {
                modifiers.append(name.name)
            }
        }

        var string = "\(key.characters)"
        var code = String(key.keyCode.rawValue)
        for special in specialKeys {
            if key.keyCode == special.code {
                code = special.name
                string = code
                break
            }
        }

        string += " (characters: “\(key.characters)” (ignoring modifiers: “\(key.charactersIgnoringModifiers)”, code: \(code)"

        if !modifiers.isEmpty {
            string += ", modifiers: " + modifiers.joined(separator: ", ")
        }
        string += ")"

        return string
    }
    
    func scrolToBottom() {
        testView.scrollRangeToVisible(NSRange(location: testView.text.count - 1, length: 1))
    }
}

