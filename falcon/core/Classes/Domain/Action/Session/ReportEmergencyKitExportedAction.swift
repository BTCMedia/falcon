//
//  ReportEmergencyKitExportedAction.swift
//  core.root-all-notifications
//
//  Created by Manu Herrera on 14/05/2020.
//

import Foundation
import RxSwift

public class ReportEmergencyKitExportedAction: AsyncAction<()> {

    private let houstonService: HoustonService
    private let sessionActions: SessionActions

    public init(houstonService: HoustonService, sessionActions: SessionActions) {
        self.houstonService = houstonService
        self.sessionActions = sessionActions

        super.init(name: "ReportEmergencyKitExportedAction")
    }

    public func run(date: Date, verificationCode: String, isVerified: Bool) {
        let exportKit = ExportEmergencyKit(
            lastExportedAt: date,
            verificationCode: verificationCode,
            verified: isVerified
        )
        runSingle(houstonService.setEmergencyKitExported(exportEmergencyKit: exportKit).map({
            if isVerified {
                self.sessionActions.setEmergencyKitExported(date: date)
            }
        }))
    }

}
