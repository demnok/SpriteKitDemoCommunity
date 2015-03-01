//
//  NavigationControllerProtocol.swift
//  SpriteKit Demo
//
//  Created by Stolniceanu Stefan on 19/02/15.
//  Copyright (c) 2015 Stefan Stolniceanu. All rights reserved.
//

import SpriteKit

protocol NavigationControllerDelegate {
    func populateWithControls()
    func didReceiveError()
}
