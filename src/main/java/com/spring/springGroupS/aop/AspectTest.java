package com.spring.springGroupS.aop;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Pointcut;

//@EnableAspectJAutoProxy
//@Aspect
//@Component
public class AspectTest {
	// getAopServiceTest1() 메소드 전, 후에 메시지를 출력하시오.
//	@Around("execution(* com.spring.springGroupS.service.Study1Service.getAopServiceTest1(..))")
//	public void aroundAdvice(ProceedingJoinPoint joinPoint) throws Throwable {
//		System.out.println("\n이곳은 aroundAdvice 메소드이며 핵심관심사 수행 전입니다.\n");
//		joinPoint.proceed();
//		System.out.println("이곳은 aroundAdvice 메소드이며 핵심관심사 수행 후입니다.\n");
//	}
	
//	// getAopServiceTest3() 메소드 전에 메시지를 출력하시오.
//	@Before("execution(* com.spring.springGroupS.service.Study1Service.getAopServiceTest3(..))")
//	public void beforeAdvice() {
//		System.out.println("\n이곳은 beforeAdvice 메소드이며 핵심관심사 수행 전입니다.\n");
//	}
	
//	// getAopServiceTest2() 메소드 수행결과를 콘솔에 출력하시오.
//	@AfterReturning(value="execution(* com.spring.springGroupS.service.Study1Service.getAopServiceTest2(..))", returning="result")
//	public void afterReturningAdvice(JoinPoint joinPoint, Object result) {
//		System.out.println("이곳은 afterReturningAdvice 메소드이며 핵심코드의 수행결과는 "+result.toString()+"입니다.\n");
//	}
	
//	// getAopServiceTest2() 메소드, getAopServiceTest3() 메소드, 모든 메소드가 수행하는데 걸리는 시간을 구하시오.
//	long startTime, endTime;
//	
//	@Pointcut("execution(* com.spring.springGroupS.service.Study1Service.getAopServiceTest5*(..))")
//	private void cut() {}
//	
//	@Around("cut()")
//	public void aroundAdvice2(ProceedingJoinPoint joinPoint) throws Throwable {
//		startTime = System.nanoTime();
//		System.out.println("핵심관심사 수행 전입니다."+joinPoint);
//		joinPoint.proceed();
//		System.out.println("핵심관심사 수행 후입니다."+joinPoint);
//		endTime = System.nanoTime();
//		long res = endTime - startTime;
//		System.out.println("수행시간: "+res);
//	}
	
//	 Study1Service객체 안의 모든 메소드의 수행시간을 해당 메소드 이름과 함께 출력하시오.
	long startTime, endTime;
	@Pointcut("execution(* com.spring.springGroupS.service.Study1Service.*(..))")
	private void cutAll() {}
	@Around("cutAll()")
	public Object aroundAdviceAll(ProceedingJoinPoint joinPoint) throws Throwable {
		startTime = System.nanoTime();
		try {
			Object result = joinPoint.proceed();
			return result;
		} finally {
			System.out.println("핵심관심사 수행 전입니다.");
			joinPoint.proceed();
			System.out.println("핵심관심사 수행 후입니다.");
			endTime = System.nanoTime();
			long res = endTime - startTime;
			System.out.println(joinPoint.toString().substring(joinPoint.toString().lastIndexOf(".")+1, joinPoint.toString().lastIndexOf("("))+"의 수행시간: "+res+"\n");
		}
	}
}
