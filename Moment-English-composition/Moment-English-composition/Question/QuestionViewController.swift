//
//  QuestionViewController.swift
//  Moment-English-composition
//
//  Created by 信次　智史 on 2019/03/31.
//  Copyright © 2019 stoshi nobutsugu. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class QuestionViewController: UIViewController {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var questionText: UITextView!
    @IBOutlet var answerText: UITextView!
    @IBOutlet var anserView: UIStackView!
    @IBOutlet var nextBtn: UIButton!
    
    var indexCount = 0
    var maxCount = 0
    
    var majorKey: String = ""
    var questionDatas: Results<QustionData>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(majorKey)
        questionDatas = QustionData.getDatasByMajor(majorKey: majorKey)
        maxCount = questionDatas.count
        print(questionDatas[indexCount].minor)
        print(questionDatas[indexCount].question)
        print(questionDatas[indexCount].answer)
        reloadView(indexCount: indexCount)
    }
    
    @IBAction func showAnswer(_ sender: Any) {
        anserView.isHidden = false
    }
    
    @IBAction func tapNextBtn(_ sender: Any) {
        
        if (indexCount + 1) < maxCount {
            indexCount += 1
            reloadView(indexCount: indexCount)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    private func reloadView(indexCount: Int) {
        titleLabel.text = questionDatas[indexCount].minor
        questionText.text = questionDatas[indexCount].question
        answerText.text =
            questionDatas[indexCount].answer
        anserView.isHidden = true
        if (indexCount + 1) == maxCount {
            nextBtn.setTitle("end", for: .normal)
        }
    }
}
