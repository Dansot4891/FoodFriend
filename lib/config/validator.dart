String? pwValidator(String? val) {
  if (val!.length > 16 || val.length < 8) {
    if (val.isEmpty) {
      return '비밀번호를 입력해주세요.';
    }
    return '올바른 비밀번호를 입력해주세요';
  } else {
    return null;
  }
}

String? nameValidator(String? val) {
  if (val!.length > 16 || val.length < 3) {
    if (val.isEmpty) {
      return '이름을 입력해주세요.';
    }
    return '올바른 이름을 입력해주세요';
  } else {
    return null;
  }
}

String? emailValidator(String? val) {
  if (val!.isEmpty) {
    return '필수 질문입니다.';
  } else if (!RegExp(
          r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
      .hasMatch(val)) {
    return '올바른 이메일 형식을 입력해주세요.';
  }
  return null;
}

String? idValidator(String? val) {
  if (val!.length > 20 || val.length < 5) {
    if (val.isEmpty) {
      return '아이디 입력해주세요.';
    }
    return '올바른 이름을 입력해주세요';
  } else {
    return null;
  }
}

String? depValidator(String? val) {
  if (val!.length > 30 || val.length < 3) {
    if (val.isEmpty) {
      return '학과를 입력해주세요.';
    }
    return '올바른 학과를 입력해주세요';
  } else {
    return null;
  }
}

String? titleValidator(String? val) {
    if (val!.isEmpty) {
      return '제목을 입력해주세요.';
    }
    return null;
}

String? maxValidator(String? val) {
  if (val!.isEmpty) {
      return '인원 수를 설정해주세요.';
    }
    return null;
}

String? timeValidator(String? val) {
  if (val!.isEmpty) {
      return '시간대를 설정해주세요.';
    }
    return null;
}

String? placeValidator(String? val) {
  if (val!.isEmpty) {
      return '장소를 설정해주세요.';
    }
    return null;
}