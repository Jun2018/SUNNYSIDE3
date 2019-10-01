package kr.co.sunnyside.branchinfo.service;

import java.util.List;

import kr.co.sunnyside.cmn.DTO;

public interface LGS_BranchInfoSvc {
	
	public int do_save(DTO dto);

	public int do_delete(DTO dto);

	public int do_update(DTO dto);

	public List<?> get_retrieve(DTO dto);

	public DTO get_selectOne(DTO dto);
	
}
