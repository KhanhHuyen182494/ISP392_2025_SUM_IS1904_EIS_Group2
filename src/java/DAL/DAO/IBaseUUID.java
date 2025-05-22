/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package DAL.DAO;

import java.util.List;

/**
 *
 * @author Huyen
 * @param <T>
 */
public interface IBaseUUID<T> {
    public T getById(String id);
    
    public List<T> getAll();
    
    public boolean add(T t);
    
    public boolean deleteById(String id); //Just update status, not deleted whole
    
    public boolean update(T t);
}
