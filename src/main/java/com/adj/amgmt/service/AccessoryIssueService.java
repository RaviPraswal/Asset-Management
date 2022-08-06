package com.adj.amgmt.service;

import java.util.List;

import com.adj.amgmt.dto.AccessoryIssueDTO;
import com.adj.amgmt.entity.AccessoryIssue;

public interface AccessoryIssueService {

	List<AccessoryIssueDTO> getAccessoryIssuesList();

	boolean saveAccessoryIssue(AccessoryIssueDTO accessoryIssueDTO);

	void deleteAccessoryIssueById(int id);

	void updateAccessoryIssue(AccessoryIssue accessoryIssues);

	AccessoryIssueDTO getAccessoryIssueById(int accessoryIssueId);

}
