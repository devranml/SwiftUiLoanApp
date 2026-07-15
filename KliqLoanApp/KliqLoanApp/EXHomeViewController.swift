////
////  HomeViewController.swift
////  KliqLoanApp
////
////  Created by Kliq Tech on 2.02.2025.
////
//
//import UIKit
//
//// MARK: - HomeViewController
//class HomeViewController: UIViewController {
//    private static func makeDefaultRepository() -> LoanRepository {
//        let strategyFactory = LoanStrategyFactory(
//            strategies: [
//                PersonalLoanInterestStrategy(),
//                MortgageLoanInterestStrategy(),
//                AutoLoanInterestStrategy(),
//                BusinessLoanInterestStrategy()
//            ]
//        )
//        return LoanRepository(service: MockLoanService(), strategyFactory: strategyFactory)
//    }
//    
//    private let tableView = UITableView()
//    private let segmentControl = UISegmentedControl(items: ["All", "Active", "Overdue", "Default", "Paid"])
//    private let summaryView = UIView()
//    private let totalLabel = UILabel()
//    private let countLabel = UILabel()
//    private let avgRateLabel = UILabel()
//    private var allLoans: [Loan] = []
//    private var filteredLoans: [Loan] = []
//    private let repository: LoanRepository
//    private let refreshControl = UIRefreshControl()
//
//    init(repository: LoanRepository = HomeViewController.makeDefaultRepository()) {
//        self.repository = repository
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        buildUI()
//        loadData()
//    }
//
//    private func buildUI() {
//        view.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.97, alpha: 1.0)
//        title = "Loan Portfolio"
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
//
//        // Summary card
//        summaryView.backgroundColor = UIColor(red: 0.13, green: 0.17, blue: 0.27, alpha: 1.0)
//        summaryView.layer.cornerRadius = 14
//        summaryView.translatesAutoresizingMaskIntoConstraints = false
//
//        totalLabel.textColor = .white
//        totalLabel.font = UIFont.boldSystemFont(ofSize: 22)
//        totalLabel.translatesAutoresizingMaskIntoConstraints = false
//
//        countLabel.textColor = UIColor(white: 1.0, alpha: 0.85)
//        countLabel.font = UIFont.systemFont(ofSize: 13)
//        countLabel.translatesAutoresizingMaskIntoConstraints = false
//
//        avgRateLabel.textColor = UIColor(white: 1.0, alpha: 0.85)
//        avgRateLabel.font = UIFont.systemFont(ofSize: 13)
//        avgRateLabel.translatesAutoresizingMaskIntoConstraints = false
//
//        view.addSubview(summaryView)
//        summaryView.addSubview(totalLabel)
//        summaryView.addSubview(countLabel)
//        summaryView.addSubview(avgRateLabel)
//
//        // Segment
//        segmentControl.selectedSegmentIndex = 0
//        segmentControl.addTarget(self, action: #selector(filterChanged), for: .valueChanged)
//        segmentControl.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(segmentControl)
//
//        // Table
//        tableView.dataSource = self
//        tableView.delegate = self
//        tableView.backgroundColor = .clear
//        tableView.separatorStyle = .none
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
//        tableView.refreshControl = refreshControl
//        view.addSubview(tableView)
//
//        NSLayoutConstraint.activate([
//            summaryView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
//            summaryView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//            summaryView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
//            summaryView.heightAnchor.constraint(equalToConstant: 100),
//
//            totalLabel.topAnchor.constraint(equalTo: summaryView.topAnchor, constant: 16),
//            totalLabel.leadingAnchor.constraint(equalTo: summaryView.leadingAnchor, constant: 20),
//
//            countLabel.topAnchor.constraint(equalTo: totalLabel.bottomAnchor, constant: 6),
//            countLabel.leadingAnchor.constraint(equalTo: summaryView.leadingAnchor, constant: 20),
//
//            avgRateLabel.topAnchor.constraint(equalTo: countLabel.bottomAnchor, constant: 4),
//            avgRateLabel.leadingAnchor.constraint(equalTo: summaryView.leadingAnchor, constant: 20),
//
//            segmentControl.topAnchor.constraint(equalTo: summaryView.bottomAnchor, constant: 12),
//            segmentControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//            segmentControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
//
//            tableView.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: 10),
//            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//        ])
//    }
//
//    private func loadData() {
//        Task {
//            do {
//                allLoans = try await repository.updateLoans()
//                DispatchQueue.main.async {
//                    self.applyFilter()
//                    self.refreshControl.endRefreshing()
//                }
//            } catch {
//                DispatchQueue.main.async {
//                    self.refreshControl.endRefreshing()
//                    let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
//                    alert.addAction(UIAlertAction(title: "OK", style: .default))
//                    self.present(alert, animated: true)
//                }
//            }
//        }
//    }
//
//    @objc private func filterChanged() {
//        applyFilter()
//    }
//
//    @objc private func handleRefresh() {
//        loadData()
//    }
//
//    @objc private func handleLogout() {
//        navigationController?.popToRootViewController(animated: true)
//    }
//    
//    // All business logic mixed into ViewController
//    private func applyFilter() {
//        let index = segmentControl.selectedSegmentIndex
//        if index == 0 {
//            filteredLoans = allLoans
//        } else if index == 1 {
//            filteredLoans = allLoans.filter { $0.status == .active }
//        } else if index == 2 {
//            filteredLoans = allLoans.filter { $0.status == .overdue }
//        } else if index == 3 {
//            filteredLoans = allLoans.filter { $0.status == .default }
//        } else if index == 4 {
//            filteredLoans = allLoans.filter { $0.status == .paid }
//        }
//        updateSummary()
//        tableView.reloadData()
//    }
//
//    // Business logic that should be in ViewModel
//    private func updateSummary() {
//        var total: Double = 0
//        var rateSum: Double = 0
//        for loan in filteredLoans {
//            total += loan.principalAmount
//            rateSum += loan.interestRate
//        }
//        let avgRate = filteredLoans.isEmpty ? 0.0 : rateSum / Double(filteredLoans.count)
//
//        // Hardcoded formatting instead of proper NumberFormatter
//        totalLabel.text = "$\(String(format: "%.0f", total))"
//        countLabel.text = "\(filteredLoans.count) loans in portfolio"
//        avgRateLabel.text = "Avg. interest rate: \(String(format: "%.2f", avgRate))%"
//    }
//
//    // Color logic embedded in ViewController instead of a provider
//    private func colorForStatus(_ status: String) -> UIColor {
//        if status == "active" {
//            return UIColor(red: 0.18, green: 0.72, blue: 0.45, alpha: 1.0)
//        } else if status == "overdue" {
//            return UIColor(red: 0.95, green: 0.62, blue: 0.15, alpha: 1.0)
//        } else if status == "default" {
//            return UIColor(red: 0.90, green: 0.22, blue: 0.21, alpha: 1.0)
//        } else if status == "paid" {
//            return UIColor(red: 0.55, green: 0.55, blue: 0.58, alpha: 1.0)
//        }
//        return .darkGray
//    }
//
//    // Type badge color - another place where color logic is scattered
//    private func colorForType(_ type: String) -> UIColor {
//        if type == "personal" {
//            return UIColor(red: 0.13, green: 0.17, blue: 0.27, alpha: 1.0)
//        } else if type == "mortgage" {
//            return UIColor(red: 0.16, green: 0.50, blue: 0.73, alpha: 1.0)
//        } else if type == "auto" {
//            return UIColor(red: 0.20, green: 0.60, blue: 0.56, alpha: 1.0)
//        } else if type == "business" {
//            return UIColor(red: 0.58, green: 0.34, blue: 0.14, alpha: 1.0)
//        }
//        return .gray
//    }
//}
//
//// MARK: - UITableViewDataSource & Delegate
//extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return filteredLoans.count
//    }
//
//    // No reusable cell, all UI built inline
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
//        cell.selectionStyle = .none
//        cell.backgroundColor = .clear
//        cell.contentView.subviews.forEach { $0.removeFromSuperview() }
//
//        let loan = filteredLoans[indexPath.row]
//
//        let card = UIView()
//        card.backgroundColor = .white
//        card.layer.cornerRadius = 12
//        card.layer.shadowColor = UIColor.black.cgColor
//        card.layer.shadowOpacity = 0.06
//        card.layer.shadowRadius = 6
//        card.layer.shadowOffset = CGSize(width: 0, height: 2)
//        card.translatesAutoresizingMaskIntoConstraints = false
//
//        let nameLabel = UILabel()
//        nameLabel.text = loan.name
//        nameLabel.font = UIFont.boldSystemFont(ofSize: 15)
//        nameLabel.textColor = UIColor(red: 0.15, green: 0.15, blue: 0.20, alpha: 1.0)
//        nameLabel.translatesAutoresizingMaskIntoConstraints = false
//
//        let typeBadge = UILabel()
//        typeBadge.text = " \(loan.type.rawValue.uppercased()) "
//        typeBadge.font = UIFont.boldSystemFont(ofSize: 10)
//        typeBadge.textColor = .white
//        typeBadge.backgroundColor = colorForType(loan.type.rawValue)
//        typeBadge.layer.cornerRadius = 4
//        typeBadge.layer.masksToBounds = true
//        typeBadge.translatesAutoresizingMaskIntoConstraints = false
//
//        let statusBadge = UILabel()
//        statusBadge.text = " \(loan.status.rawValue.uppercased()) "
//        statusBadge.font = UIFont.boldSystemFont(ofSize: 10)
//        statusBadge.textColor = .white
//        statusBadge.backgroundColor = colorForStatus(loan.status.rawValue)
//        statusBadge.layer.cornerRadius = 4
//        statusBadge.layer.masksToBounds = true
//        statusBadge.translatesAutoresizingMaskIntoConstraints = false
//
//        let amountLabel = UILabel()
//        amountLabel.text = "$\(String(format: "%.0f", loan.principalAmount))"
//        amountLabel.font = UIFont.boldSystemFont(ofSize: 18)
//        amountLabel.textColor = UIColor(red: 0.15, green: 0.15, blue: 0.20, alpha: 1.0)
//        amountLabel.translatesAutoresizingMaskIntoConstraints = false
//
//        let rateLabel = UILabel()
//        rateLabel.text = "\(String(format: "%.1f", loan.interestRate))% interest"
//        rateLabel.font = UIFont.systemFont(ofSize: 12)
//        rateLabel.textColor = .gray
//        rateLabel.translatesAutoresizingMaskIntoConstraints = false
//
//        let dueLabel = UILabel()
//        if loan.dueIn > 0 {
//            dueLabel.text = "\(loan.dueIn) days remaining"
//            dueLabel.textColor = UIColor(red: 0.18, green: 0.72, blue: 0.45, alpha: 1.0)
//        } else if loan.dueIn == 0 {
//            dueLabel.text = "Due today"
//            dueLabel.textColor = UIColor(red: 0.95, green: 0.62, blue: 0.15, alpha: 1.0)
//        } else {
//            dueLabel.text = "\(abs(loan.dueIn)) days overdue"
//            dueLabel.textColor = UIColor(red: 0.90, green: 0.22, blue: 0.21, alpha: 1.0)
//        }
//        dueLabel.font = UIFont.systemFont(ofSize: 12)
//        dueLabel.translatesAutoresizingMaskIntoConstraints = false
//
//        cell.contentView.addSubview(card)
//        card.addSubview(nameLabel)
//        card.addSubview(typeBadge)
//        card.addSubview(statusBadge)
//        card.addSubview(amountLabel)
//        card.addSubview(rateLabel)
//        card.addSubview(dueLabel)
//
//        NSLayoutConstraint.activate([
//            card.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 6),
//            card.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 16),
//            card.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -16),
//            card.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor, constant: -6),
//
//            nameLabel.topAnchor.constraint(equalTo: card.topAnchor, constant: 14),
//            nameLabel.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 16),
//
//            typeBadge.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
//            typeBadge.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 8),
//
//            statusBadge.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
//            statusBadge.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -16),
//
//            amountLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
//            amountLabel.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 16),
//
//            rateLabel.centerYAnchor.constraint(equalTo: amountLabel.centerYAnchor),
//            rateLabel.leadingAnchor.constraint(equalTo: amountLabel.trailingAnchor, constant: 12),
//
//            dueLabel.topAnchor.constraint(equalTo: amountLabel.bottomAnchor, constant: 8),
//            dueLabel.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 16),
//            dueLabel.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -14)
//        ])
//
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 120
//    }
//}
