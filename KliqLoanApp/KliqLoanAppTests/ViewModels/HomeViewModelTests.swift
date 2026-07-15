//
//  HomeViewModelTests.swift
//  KliqLoanApp
//
//  Created by Machine Dev on 15.07.2026.
//

@testable import KliqLoanApp
import XCTest

@MainActor
final class HomeViewModelTests: XCTestCase {
    private var updateLoansUseCase:
        MockUpdateLoansUseCase!

    private var logoutUseCase:
        MockLogoutUseCase!

    private var logoutSuccessCallCount: Int!
    private var sut: HomeViewModel!

    override func setUp() {
        super.setUp()

        updateLoansUseCase =
            MockUpdateLoansUseCase()

        logoutUseCase =
            MockLogoutUseCase()

        logoutSuccessCallCount = 0

        sut = HomeViewModel(
            updateLoansUseCase:
                updateLoansUseCase,
            logoutUseCase:
                logoutUseCase,
            onLogoutSuccess: { [weak self] in
                self?.logoutSuccessCallCount += 1
            }
        )
    }

    override func tearDown() {
        updateLoansUseCase = nil
        logoutUseCase = nil
        sut = nil
        logoutSuccessCallCount = nil

        super.tearDown()
    }

    func test_loadLoans_setsReturnedLoans() async {
        let loans = [
            Loan.fixture(
                name: "Personal",
                type: .personal
            ),
            Loan.fixture(
                name: "Mortgage",
                type: .mortgage
            )
        ]

        updateLoansUseCase.loansToReturn = loans

        await sut.loadLoans()

        XCTAssertEqual(updateLoansUseCase.callCount, 1)
        XCTAssertEqual(sut.loans, loans)
        XCTAssertFalse(sut.isLoading)
        XCTAssertNil(sut.errorMessage)
    }

    func test_loadLoans_whenUseCaseFails_setsError() async {
        updateLoansUseCase.errorToThrow =
            TestError.expected

        await sut.loadLoans()

        XCTAssertTrue(sut.loans.isEmpty)
        XCTAssertNotNil(sut.errorMessage)
        XCTAssertFalse(sut.isLoading)
    }

    func test_activeFilter_returnsOnlyActiveLoans() async {
        updateLoansUseCase.loansToReturn = [
            Loan.fixture(
                name: "Active",
                status: .active
            ),
            Loan.fixture(
                name: "Overdue",
                status: .overdue
            )
        ]

        await sut.loadLoans()
        sut.selectedFilter = .active

        XCTAssertEqual(
            sut.filteredLoans.map(\.name),
            ["Active"]
        )
    }

    func test_overdueFilter_returnsOnlyOverdueLoans() async {
        updateLoansUseCase.loansToReturn = [
            Loan.fixture(
                name: "Active",
                status: .active
            ),
            Loan.fixture(
                name: "Overdue",
                status: .overdue
            )
        ]

        await sut.loadLoans()
        sut.selectedFilter = .overdue

        XCTAssertEqual(
            sut.filteredLoans.map(\.name),
            ["Overdue"]
        )
    }

    func test_summary_usesFilteredLoans() async {
        updateLoansUseCase.loansToReturn = [
            Loan.fixture(
                principalAmount: 10_000,
                interestRate: 4,
                status: .active
            ),
            Loan.fixture(
                principalAmount: 20_000,
                interestRate: 6,
                status: .active
            ),
            Loan.fixture(
                principalAmount: 100_000,
                interestRate: 20,
                status: .overdue
            )
        ]

        await sut.loadLoans()
        sut.selectedFilter = .active

        XCTAssertEqual(sut.totalAmount, 30_000)
        XCTAssertEqual(
            sut.averageRate,
            5,
            accuracy: 0.0001
        )
        XCTAssertEqual(
            sut.loanCountText,
            AppStrings.Home.loanCount(2)
        )
        XCTAssertEqual(
            sut.averageRateText,
            AppStrings.Home.averageRate(5)
        )
    }

    func test_onAppear_loadsOnlyOnceWhenLoansExist() async {
        updateLoansUseCase.loansToReturn = [
            Loan.fixture()
        ]

        await sut.onAppear()
        await sut.onAppear()

        XCTAssertEqual(
            updateLoansUseCase.callCount,
            1
        )
    }

    func test_logout_callsUseCaseAndSuccessCallback() async {
        await sut.logout()

        XCTAssertEqual(logoutUseCase.callCount, 1)
        XCTAssertEqual(logoutSuccessCallCount, 1)
    }

    func test_logout_whenUseCaseFails_doesNotCallSuccessCallback() async {
        logoutUseCase.errorToThrow =
            TestError.expected

        await sut.logout()

        XCTAssertEqual(logoutUseCase.callCount, 1)
        XCTAssertEqual(logoutSuccessCallCount, 0)
        XCTAssertNotNil(sut.errorMessage)
    }
}
