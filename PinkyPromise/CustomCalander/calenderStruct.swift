//
//  calenderStruct.swift
//  DemoCalender
//
//  Created by Mithilesh kumar satnami on 20/05/22.
//

import Foundation
import HorizonCalendar
import UIKit

struct DayLabel: CalendarItemViewRepresentable {
    
    /// Properties that are set once when we initialize the view.
    struct InvariantViewProperties: Hashable {
        var font: UIFont
        var textColor: UIColor
        var backgroundColor: UIColor
        var cornerRadius: CGFloat
        var borderWidth: CGFloat
        var borderColor: UIColor
        var shadowColor: UIColor
    }
    
    /// Properties that will vary depending on the particular date being displayed.
    struct ViewModel: Equatable {
        let day: Day
    }
    
    static func makeView(
        withInvariantViewProperties invariantViewProperties: InvariantViewProperties)
    -> UILabel
    {
        let label = UILabel()
        
        label.backgroundColor = invariantViewProperties.backgroundColor
        label.font = invariantViewProperties.font
        label.textColor = invariantViewProperties.textColor
        
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.cornerRadius = invariantViewProperties.cornerRadius
        label.layer.borderWidth = invariantViewProperties.borderWidth
        label.layer.borderColor = invariantViewProperties.borderColor.cgColor
        label.clipsToBounds = true
//        label.layer.shadowOffset = CGSize(width: 2, height: 3)
//        label.layer.shadowOpacity = 1
//        label.layer.shadowRadius = 4
//        label.layer.shadowColor = invariantViewProperties.shadowColor.cgColor
//        label.layer.masksToBounds = false
        return label
    }
    
    static func setViewModel(_ viewModel: ViewModel, on view: UILabel) {
        view.text = "\(viewModel.day.day)"
    }
    
}

extension TooltipView: CalendarItemViewRepresentable {
    
    struct InvariantViewProperties: Hashable {
        let backgroundColor: UIColor
        let borderColor: UIColor
        let font: UIFont
        let textColor: UIColor
    }
    
    struct ViewModel: Equatable {
        let frameOfTooltippedItem: CGRect?
        let text: String
    }
    
    static func makeView(
        withInvariantViewProperties invariantViewProperties: InvariantViewProperties)
    -> TooltipView
    {
        TooltipView(
            backgroundColor: .yellow, borderColor: invariantViewProperties.borderColor,
            font: invariantViewProperties.font,
            textColor: invariantViewProperties.textColor)
    }
    
    static func setViewModel(_ viewModel: ViewModel, on view: TooltipView) {
        view.frameOfTooltippedItem = viewModel.frameOfTooltippedItem
        view.text = viewModel.text
    }
    
}
