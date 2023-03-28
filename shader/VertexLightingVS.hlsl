//���_�V�F�[�_�[
#include "Header.hlsli" //�K���C���N���[�h
//
//in �͓��͂���Ă���f�[�^�[
//out �͏o�͂���f�[�^
//
void main(in VS_IN In, out PS_IN Out)
{
	//�P���_���̃f�[�^���󂯎��A�������āA�o�͂���
	//���_�ϊ����� ���̏����͕K���K�v
	matrix wvp; //�s��ϐ����쐬
	wvp = mul(World, View); //wvp = ���[���h�s�񁖃J�����s��
	wvp = mul(wvp, Projection); //wvp = wvp *�v���W�F�N�V�����s��
	Out.Position = mul(In.Position, wvp); //�ϊ����ʂ��o�͂���

	//���_�@�������[���h�s��ŉ�]������(���_�Ɠ�����]��������)
	float4 worldNormal, normal;				//���[�J���ϐ����쐬
	normal = float4(In.Normal.xyz, 0.0);	//�@���x�N�g����w��0�Ƃ��ăR�s�[�i���s�ړ����Ȃ�����)
	worldNormal = mul(normal, World);		//�@�������[���h�s��ŉ�]����
	worldNormal = normalize(worldNormal);	//��]��̖@���𐳋K������
	Out.Normal = worldNormal;				//��]��̖@���o�� In.Normal�łȂ���]��̖@�����o��

	//���邳�̌v�Z
    float light = -dot(Light.Direction.xyz, Out.Normal.xyz);
	light = saturate(light); //���邳��0��1�̊ԂŖO�a������	
	
	
	Out.Diffuse.rgb = light; //���邳�𒸓_�F�Ƃ��ďo��
	Out.Diffuse.a = In.Diffuse.a; //���͒��_�̕������̂܂܏o��										  

	//�e�N�X�`�����W���o��
	Out.TexCoord = In.TexCoord;

    Out.WorldPosition = mul(In.Position, World);
}