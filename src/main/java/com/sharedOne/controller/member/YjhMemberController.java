package com.sharedOne.controller.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sharedOne.domain.member.RanksDto;
import com.sharedOne.domain.member.MemberDto;
import com.sharedOne.service.member.YjhMemberService;

@Controller
@RequestMapping("member")
public class YjhMemberController {
	
	@Autowired
	YjhMemberService service;
	
	@RequestMapping("login")
	@PreAuthorize("not isAuthenticated()")
	public void login() {
		
	}
	
	@GetMapping("signup")
	@PreAuthorize("hasAuthority('팀장')")
	public void signup() {
	}
	
	@PostMapping("signup")
	@PreAuthorize("hasAuthority('팀장')")
	public void signup(MemberDto member , RanksDto rank) {
		
		int cnt1 = service.insertMember(member);
		
		int cnt2 = service.insertRanks(rank);

	}
}
