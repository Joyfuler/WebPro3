package com.lec.ex01;
// CONSTANT_NUM, method1(�߻�) . �޼ҵ�1,2�� �ݵ�� �������̵�
public class ClassEx implements InterfaceEx1, InterfaceEx2 {

	@Override
	public void method1() {
		System.out.println("���� ������ implements�� �� Ŭ�������� ��. - method1�� ���");
	} // �������̽�1�� ��������

	@Override
	public void method2() {
		System.out.println("���� ������ implements�� �� Ŭ�������� ��. - method2�� ���");
			
	}
}