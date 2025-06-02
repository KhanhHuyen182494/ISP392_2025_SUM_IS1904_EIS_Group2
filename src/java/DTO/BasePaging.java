/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DTO;

import java.util.List;

/**
 *
 * @author Huyen
 * Base paging for all items needed
 * @param <T>
 */
public class BasePaging<T> {
    private int current_page;
    private int page_size;
    private int total_records;
    private int total_pages;
    private List<T> items;
    private String sort_by;
    
    private String searchKey;

    public BasePaging() {
        this.searchKey = "";
    }

    public int getCurrent_page() {
        return current_page;
    }

    public void setCurrent_page(int current_page) {
        this.current_page = current_page;
    }

    public int getPage_size() {
        return page_size;
    }

    public void setPage_size(int page_size) {
        this.page_size = page_size;
    }

    public int getTotal_records() {
        return total_records;
    }

    public void setTotal_records(int total_records) {
        this.total_records = total_records;
    }

    public int getTotal_pages() {
        return total_pages;
    }

    public void setTotal_pages(int total_pages) {
        this.total_pages = total_pages;
    }

    public List<T> getItems() {
        return items;
    }

    public void setItems(List<T> items) {
        this.items = items;
    }

    public String getSort_by() {
        return sort_by;
    }

    public void setSort_by(String sort_by) {
        this.sort_by = sort_by;
    }

    public String getSearchKey() {
        return searchKey;
    }

    public void setSearchKey(String searchKey) {
        this.searchKey = searchKey;
    }

    @Override
    public String toString() {
        return "BasePaging{" + "current_page=" + current_page + ", page_size=" + page_size + ", total_records=" + total_records + ", total_pages=" + total_pages + ", items=" + items + ", sort_by=" + sort_by + ", searchKey=" + searchKey + '}';
    }
    
    
}
