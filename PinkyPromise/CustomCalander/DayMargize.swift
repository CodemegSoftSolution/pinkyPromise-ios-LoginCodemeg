//
//  DayMargize.swift
//  DemoCalender
//
//  Created by Mithilesh kumar satnami on 20/05/22.
//

import Foundation
import UIKit
import HorizonCalendar

class DayRangeIndicatorView: UIView {
    private let indicatorColor: UIColor
    let viewbg:UIView = UIView()
    
    init(indicatorColor: UIColor) {
        self.indicatorColor = indicatorColor
        super.init(frame: viewbg.frame)
        backgroundColor = .clear
        layer.shadowOffset = CGSize(width: 2, height: 3)
        layer.shadowOpacity = 1
        layer.shadowRadius = 4
        layer.shadowColor = UIColor.init(red: 255/255.0, green: 230/255.0, blue: 179/255.0, alpha: 1).cgColor
        layer.masksToBounds = false
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    var framesOfDaysToHighlight = [CGRect]() {
        didSet {
            guard framesOfDaysToHighlight != oldValue else { return }
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(indicatorColor.cgColor)
        
        // Get frames of day rows in the range
        var dayRowFrames = [CGRect]()
        var currentDayRowMinY: CGFloat?
        for dayFrame in framesOfDaysToHighlight {
            if dayFrame.minY != currentDayRowMinY {
                currentDayRowMinY = dayFrame.minY
                dayRowFrames.append(dayFrame)
            } else {
                let lastIndex = dayRowFrames.count - 1
                dayRowFrames[lastIndex] = dayRowFrames[lastIndex].union(dayFrame)
            }
        }
        
        // Draw rounded rectangles for each day row
        for dayRowFrame in dayRowFrames {
            let roundedRectanglePath = UIBezierPath(roundedRect: dayRowFrame, cornerRadius: 12)
            context?.addPath(roundedRectanglePath.cgPath)
            context?.fillPath()
        }
    }
    
}

extension DayRangeIndicatorView: CalendarItemViewRepresentable {
    
    struct InvariantViewProperties: Hashable {
        let indicatorColor = UIColor.init(red: 240/255.0, green: 203/255.0, blue: 123/255.0, alpha: 1)
    }
    
    struct ViewModel: Equatable {
        let framesOfDaysToHighlight: [CGRect]
    }
    
    static func makeView(
        withInvariantViewProperties invariantViewProperties: InvariantViewProperties)
    -> DayRangeIndicatorView
    {
        DayRangeIndicatorView(indicatorColor: invariantViewProperties.indicatorColor)
        
    }
    
    static func setViewModel(_ viewModel: ViewModel, on view: DayRangeIndicatorView) {
        view.framesOfDaysToHighlight = viewModel.framesOfDaysToHighlight
    }
    
}
extension UIView {
    func addDashedBorder() {
        let color = UIColor.red.cgColor
        
        let shapeLayer:CAShapeLayer = CAShapeLayer()
        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
        
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color
        shapeLayer.lineWidth = 2
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPattern = [6,3]
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 5).cgPath
        
        self.layer.addSublayer(shapeLayer)
    }
}
