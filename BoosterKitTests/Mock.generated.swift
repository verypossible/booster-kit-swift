// Generated using Sourcery 0.9.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


#if Mocky
import SwiftyMocky
import XCTest
import Alamofire
import RealmSwift
import ObjectMapper
import AlamofireObjectMapper
@testable import BoosterKit
#else
import Sourcery
import SourceryRuntime
#endif

//swiftlint:disable identifier_name
//swiftlint:disable function_body_length
//swiftlint:disable line_length
//swiftlint:disable vertical_whitespace
//swiftlint:disable trailing_whitespace
//swiftlint:disable comma
//swiftlint:disable switch_case_alignment
//swiftlint:disable trailing_newline



// MARK: - APIManagerProtocol
class APIManagerProtocolMock: APIManagerProtocol, Mock, StaticMock {
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    var matcher: Matcher = Matcher.default
    static private var invocations: [StaticMethodType] = []
    static private var methodReturnValues: [StaticGiven] = []
    static private var methodPerformValues: [StaticPerform] = []
    static var matcher: Matcher = Matcher.default


    static func fetchData(completionClosure: @escaping () -> Void) {
        addInvocation(.sfetchData__completionClosure_completionClosure(Parameter<() -> Void>.value(completionClosure)))
		let perform = methodPerformValue(.sfetchData__completionClosure_completionClosure(Parameter<() -> Void>.value(completionClosure))) as? (@escaping () -> Void) -> Void
		perform?(completionClosure)
    }

    static func authenticateUser(email: String,                                 password: String,                                 passwordConfirmation: String,                                 completionClosure: @escaping () -> Void) {
        addInvocation(.sauthenticateUser__email_emailpassword_passwordpasswordConfirmation_passwordConfirmationcompletionClosure_completionClosure(Parameter<String>.value(email), Parameter<String>.value(password), Parameter<String>.value(passwordConfirmation), Parameter<() -> Void>.value(completionClosure)))
		let perform = methodPerformValue(.sauthenticateUser__email_emailpassword_passwordpasswordConfirmation_passwordConfirmationcompletionClosure_completionClosure(Parameter<String>.value(email), Parameter<String>.value(password), Parameter<String>.value(passwordConfirmation), Parameter<() -> Void>.value(completionClosure))) as? (String, String, String, @escaping () -> Void) -> Void
		perform?(email, password, passwordConfirmation, completionClosure)
    }

    fileprivate enum StaticMethodType {
        case sfetchData__completionClosure_completionClosure(Parameter<() -> Void>)
        case sauthenticateUser__email_emailpassword_passwordpasswordConfirmation_passwordConfirmationcompletionClosure_completionClosure(Parameter<String>, Parameter<String>, Parameter<String>, Parameter<() -> Void>)

        static func compareParameters(lhs: StaticMethodType, rhs: StaticMethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
                case (.sfetchData__completionClosure_completionClosure(let lhsCompletionclosure), .sfetchData__completionClosure_completionClosure(let rhsCompletionclosure)): 
                    guard Parameter.compare(lhs: lhsCompletionclosure, rhs: rhsCompletionclosure, with: matcher) else { return false } 
                    return true 
                case (.sauthenticateUser__email_emailpassword_passwordpasswordConfirmation_passwordConfirmationcompletionClosure_completionClosure(let lhsEmail, let lhsPassword, let lhsPasswordconfirmation, let lhsCompletionclosure), .sauthenticateUser__email_emailpassword_passwordpasswordConfirmation_passwordConfirmationcompletionClosure_completionClosure(let rhsEmail, let rhsPassword, let rhsPasswordconfirmation, let rhsCompletionclosure)): 
                    guard Parameter.compare(lhs: lhsEmail, rhs: rhsEmail, with: matcher) else { return false } 
                    guard Parameter.compare(lhs: lhsPassword, rhs: rhsPassword, with: matcher) else { return false } 
                    guard Parameter.compare(lhs: lhsPasswordconfirmation, rhs: rhsPasswordconfirmation, with: matcher) else { return false } 
                    guard Parameter.compare(lhs: lhsCompletionclosure, rhs: rhsCompletionclosure, with: matcher) else { return false } 
                    return true 
                default: return false
            }
        }

        func intValue() -> Int {
            switch self {
                case let .sfetchData__completionClosure_completionClosure(p0): return p0.intValue
                case let .sauthenticateUser__email_emailpassword_passwordpasswordConfirmation_passwordConfirmationcompletionClosure_completionClosure(p0, p1, p2, p3): return p0.intValue + p1.intValue + p2.intValue + p3.intValue
            }
        }
    }

    struct StaticGiven {
        fileprivate var method: StaticMethodType
        var returns: Any?
        var `throws`: Error?

        private init(method: StaticMethodType, returns: Any?, throws: Error?) {
            self.method = method
            self.returns = returns
            self.`throws` = `throws`
        }

    }

    struct StaticVerify {
        fileprivate var method: StaticMethodType

        static func fetchData(completionClosure: Parameter<() -> Void>) -> StaticVerify {
            return StaticVerify(method: .sfetchData__completionClosure_completionClosure(completionClosure))
        }
        static func authenticateUser(email: Parameter<String>, password: Parameter<String>, passwordConfirmation: Parameter<String>, completionClosure: Parameter<() -> Void>) -> StaticVerify {
            return StaticVerify(method: .sauthenticateUser__email_emailpassword_passwordpasswordConfirmation_passwordConfirmationcompletionClosure_completionClosure(email, password, passwordConfirmation, completionClosure))
        }
    }

    struct StaticPerform {
        fileprivate var method: StaticMethodType
        var performs: Any

        static func fetchData(completionClosure: Parameter<() -> Void>, perform: (@escaping () -> Void) -> Void) -> StaticPerform {
            return StaticPerform(method: .sfetchData__completionClosure_completionClosure(completionClosure), performs: perform)
        }
        static func authenticateUser(email: Parameter<String>, password: Parameter<String>, passwordConfirmation: Parameter<String>, completionClosure: Parameter<() -> Void>, perform: (String, String, String, @escaping () -> Void) -> Void) -> StaticPerform {
            return StaticPerform(method: .sauthenticateUser__email_emailpassword_passwordpasswordConfirmation_passwordConfirmationcompletionClosure_completionClosure(email, password, passwordConfirmation, completionClosure), performs: perform)
        }
    }

    
    fileprivate struct MethodType {
        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool { return true }
        func intValue() -> Int { return 0 }
    }

    struct Given {
        fileprivate var method: MethodType
        var returns: Any?
        var `throws`: Error?

        private init(method: MethodType, returns: Any?, throws: Error?) {
            self.method = method
            self.returns = returns
            self.`throws` = `throws`
        }

    }

    struct Verify {
        fileprivate var method: MethodType

    }

    struct Perform {
        fileprivate var method: MethodType
        var performs: Any

    }

    public func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
        methodReturnValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: UInt = 1, file: StaticString = #file, line: UInt = #line) {
        let method = method.method
        let invocations = matchingCalls(method)
        XCTAssert(invocations.count == Int(count), "Expeced: \(count) invocations of `\(method)`, but was: \(invocations.count)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }

    private func methodReturnValue(_ method: MethodType) -> (value: Any?, error: Error?) {
        let matched = methodReturnValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher)  }
        return (value: matched?.returns, error: matched?.`throws`)
    }

    private func methodPerformValue(_ method: MethodType) -> Any? {
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) }
        return matched?.performs
    }

    private func matchingCalls(_ method: MethodType) -> [MethodType] {
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher) }
    }

    static public func matchingCalls(_ method: StaticVerify) -> Int {
        return matchingCalls(method.method).count
    }

    static public func given(_ method: StaticGiven) {
        methodReturnValues.append(method)
        methodReturnValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    static public func perform(_ method: StaticPerform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    static public func verify(_ method: StaticVerify, count: UInt = 1, file: StaticString = #file, line: UInt = #line) {
        let method = method.method
        let invocations = matchingCalls(method)
        XCTAssert(invocations.count == Int(count), "Expeced: \(count) invocations of `\(method)`, but was: \(invocations.count)", file: file, line: line)
    }

    static private func addInvocation(_ call: StaticMethodType) {
        invocations.append(call)
    }

    static private func methodReturnValue(_ method: StaticMethodType) -> (value: Any?, error: Error?) {
        let matched = methodReturnValues.reversed().first { StaticMethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher)  }
        return (value: matched?.returns, error: matched?.`throws`)
    }

    static private func methodPerformValue(_ method: StaticMethodType) -> Any? {
        let matched = methodPerformValues.reversed().first { StaticMethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) }
        return matched?.performs
    }

    static private func matchingCalls(_ method: StaticMethodType) -> [StaticMethodType] {
        return invocations.filter { StaticMethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher) }
    }
}

